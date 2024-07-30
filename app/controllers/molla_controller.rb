class MollaController < ApplicationController
  before_action :set_current_chat, only: [:test, :talk, :destroy]

  #before_action :mod?
	def index
		@mokkalab = "we in the stu"
		@posts = Post.where(id: [84,85,86,87]) 
		
	end

  

  def test
    @mokkalab = "we in the stu"

    @chats = current_user.chats
    #@chat = current_chat
    @chat = current_user.chats.find_or_create_by(id: session[:chat_id])
    @messages = @chat.messages if @chat

    

    session[:chat_id] = @chat.id

  end

  def destroy
    @chat = current_user.chats.find(session[:chat_id])
    @chat.destroy
    session[:chat_id] = nil
    redirect_to test_path, notice: 'Chat was successfully destroyed.'
  end

  def talk
    #@chat = current_user.chats.find(session[:chat_id])
    @chat = current_chat
    prompt = params[:prompt]

    #prompt_message = @chat.messages.create(content: prompt, role: 'user')
    #response_message = @chat.messages.create(content: get_ai_response(prompt), role: 'bot')

    new_message = @chat.messages.create(prompt: prompt, content: get_ai_response(prompt),role:"no-post")

    @message = @chat.messages.last
    @posts = Post.where(id: [1700, 947,1986,573])
    respond_to do |format|
      format.turbo_stream
      format.html{redirect_to test_path}
    end

  end

  def new_chat
    @chat = current_user.chats.create
    session[:chat_id] = @chat.id
    redirect_to test_path
  end

  def select_chat
    @chat = current_user.chats.find(params[:id])
    session[:chat_id] = @chat.id
    redirect_to test_path
  end

 
    



  private


  def set_current_chat
    @chat = current_chat
  end

  def current_chat
    current_user.chats.find_by(id: session[:chat_id]) || current_user.chats.first
  end

  def get_ai_response(prompt)
    client = OpenAI::Client.new
    begin
      response = client.chat(
    parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: prompt}],
      max_tokens:150
      }
    )
    response = response["choices"].first["message"]["content"]

    end
  end



end
