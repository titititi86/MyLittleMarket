class SubscribersController < ApplicationController
  before_action :require_admin, :only => [ :all_subscribers, :show, :edit, :update, :destroy]

  def index
    @subscriber = Subscriber.new
  end

  def all_subscribers
    @subscribers = Subscriber.all
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)

    if @subscriber.save
      cookies[:saved_lead] = true
      redirect_to root_path, notice: "Congratulations! You subscribed to the Newsletter"
    else
      redirect_to root_path, notice: "Failed to subscribe"
    end
  end

  private

    def subscriber_params
      params.require(:subscriber).permit(:name, :email, :source)
    end

end
