# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :load_commentable, only: %i[show edit update create index]
  before_action :set_comment, only: %i[edit update destroy]

  def index
    @comments = @commentable.comments
    render json: @comments
  end

  def new; end

  def create
    @comment = @resource.comments.new(comments_params)
    @comment.creator_id = current_user.id
    if @comment.save
    else
      render :new
    end
  end

  def destroy
    @comment.destroy
  end

  def load_commentable
    byebug
    @resource = params[:resource]
    @resource = @resource.singularize.classify.constantize
    @id = params[:resource_id]

    @commentable = @resource.singularize.classify.constantize.find(@id)
  end

  def set_comment
    @comment = Comment.find_by_id(params[:id])
    redirect_to(root_url, notice: "Record not found") unless @comment
  end

  def comments_params
    params.permit(:content)
  end
end
