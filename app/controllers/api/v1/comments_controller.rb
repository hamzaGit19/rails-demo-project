# frozen_string_literal: true

class Api::V1::CommentsController < Api::V1::BaseController
  before_action :load_commentable, only: %i[show edit update create index]
  before_action :set_comment, only: %i[edit update destroy]

  def index
    @comments = @commentable.comments
    render json: @comments
  end

  def new; end

  def create
    @comment = @commentable.comments.new(comments_params)
    @comment.creator_id = 16
    if @comment.save
      render json: @comment
    else
      render json: { message: 'Error creating comment.' }
    end
  end

  def destroy
    @comment.destroy
  end

  def load_commentable
    @resource = params[:resource]
    @id = params[:resource_id]
    @commentable = @resource.singularize.classify.constantize.find(@id)
  end

  def set_comment
    @comment = Comment.find_by_id(params[:id])
    render json: { message: 'Record not found' } unless @comment
  end

  def comments_params
    params.permit(:content)
  end
end
