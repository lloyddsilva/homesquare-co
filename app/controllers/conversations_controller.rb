class ConversationsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :mailbox, :conversation

  def index
    @conversations = current_user.mailbox.conversations
  end

  def new
    logger.debug "DEBUG::Params::#{params.inspect}"

    if params[:user].present?
      @recipient = User.find_by_slug(params[:user])
      logger.debug "DEBUG::recipient::#{@recipient}"
      @existing_conversation = Conversation.participant(current_user).where('conversations.id in (?)', Conversation.participant(@recipient).collect(&:id))
      logger.debug "DEBUG::existing_conversation::#{@existing_conversation}"
      if @existing_conversation.present?
        redirect_to mailbox.conversations.find(@existing_conversation)
      end
    end
  end

  def create
    logger.debug "DEBUG::Params::#{params.inspect}"
    recipient = User.find_by_id(conversation_params(:recipient))

    conversation = current_user.
      send_message(recipient, *conversation_params(:body, :subject)).conversation

    redirect_to conversation
  end

  def reply
    current_user.reply_to_conversation(conversation, *message_params(:body, :subject))
    redirect_to conversation
  end

  def trash
    conversation.move_to_trash(current_user)
    redirect_to :conversations
  end

  def untrash
    conversation.untrash(current_user)
    redirect_to :conversations
  end

  private

  def mailbox
    @mailbox ||= current_user.mailbox
  end

  def conversation
    
    @conversation ||= mailbox.conversations.find(params[:id])
  end

  def conversation_params(*keys)
    fetch_params(:conversation, *keys)
  end

  def message_params(*keys)
    fetch_params(:message, *keys)
  end

  def fetch_params(key, *subkeys)
    params[key].instance_eval do
      case subkeys.size
      when 0 then self
      when 1 then self[subkeys.first]
      else subkeys.map{|k| self[k] }
      end
    end
  end
end
