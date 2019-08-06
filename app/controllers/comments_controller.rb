# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :load_commentable

  def index
    @comments = @commentable.comments
  end

  def new
    @comment = @commentable.comments.new
  end

  def create
    # byebug
    @comment = @commentable.comments.new(comments_params)
    @comment.creator_id = current_user.id

    if @comment.save
      redirect_to session.delete(:return_to), notice: 'Comment created'
    else
      render :new
    end
  end

  def load_commentable
    resource = params[:resource]
    id = params[:resource_id]
    @commentable = resource.singularize.classify.constantize.find(id)

    session[:return_to] ||= request.referer
  end

  def comments_params
    params.permit(:content)
  end
end
