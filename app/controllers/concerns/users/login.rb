# frozen_string_literal: true

module Concerns
  module Users
    # User Login
    module Login
      extend ActiveSupport::Concern

      def login_form; end

      def login
        @user = User.find_by(email: params[:email])&.authenticate(params[:password])
        if @user
          login_succeed_response
        else
          login_failed_response
        end
      end

      def logout
        session[:user_id] = nil
        redirect_to(:login, notice: 'ログアウトしました')
      end

      private

      def login_succeed_response
        session[:user_id] = @user.id
        respond_to do |format|
          format.html { redirect_to :posts, notice: 'ログインしました' }
          format.json { render :posts, status: :ok }
        end
      end

      def login_failed_response
        @email = params[:email]
        @password = params[:password]
        flash.now[:notice] = 'メールアドレスまたはパスワードが間違っています'
        respond_to do |format|
          format.html { render :login_form, notice: 'ログインしました' }
          format.json { render :posts, status: :ok }
        end
      end
    end
  end
end
