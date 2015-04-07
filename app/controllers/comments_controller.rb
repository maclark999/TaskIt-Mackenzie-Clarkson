class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @project = @task.project_id
    @comment = @task.comments.build(comment_params)
    @comment.task_id = params[:task_id]
    @comment.user_id = session[:user_id]
      if @comment.save
        redirect_to project_task_path(@project, @task)
      end
  end

  def edit
  end

  def update
  end

  def delete
  end

  private
  def comment_params
    params.require(:comment).permit(:description, :user_id, :task_id)
  end
end
