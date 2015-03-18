class CommentsController < ApplicationController
  before_filter :logged_in,  only: [:new, :create]

  def new
    @comment = Comment.new
  end

  # polycomment attributes (type, id) to help
  # tell what the comments are for

  def create
    if polycomment_exists
      @comment = Comment.new comment_params
      @comment.user = current_user                      
      if @comment.save
        @comments = find_project_comments
        @project = Project.find_by(name: params[:comment][:project_name])
        if params[:comment][:polycomment_type] == 'project'
          action = 0
        elsif params[:comment][:polycomment_type] == 'issue'
          action = 5
        end
        victims = @project.followers + [@project.user] - [@comment.user]
        notify_users action, 1, @comment.id, victims   
        respond_to do |format|
          format.html { redirect_to :back }
          format.js {}
        end            
      else
        redirect_to :back
        flash[:alert] = 'Something went wrong, try reposting your comment.'
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    @delete = Comment.find(params[:id])
    if @delete.user_id == current_user.id
      @delete.destroy
      redirect_to :back
    else
      flash[:alert] = "You can't delete this comment!"
      redirect_to :back
    end
  end

  private

    def logged_in
      redirect_to root_url unless !current_user.nil?
    end

    def comment_params
      params.require(:comment).permit(:polycomment_id,:polycomment_type,:issue,:body)
    end

    #to check if polycomment object exists or not
    def polycomment_exists
      if params[:comment][:polycomment_type] == "blob" || "commit" || "file"
        return true
      else
        polycomment = params[:comment][:polycomment_type]
        value = params[:comment][:polycomment_id]
        !polycomment.classify.constantize.where(id: value).nil? #returns false if object is nil
      end
    end
    
    #return all the comments associated with polycomment object
    def find_project_comments
      @comments = Comment.where(polycomment_type: params[:comment][:polycomment_type],
                              polycomment_id: params[:comment][:polycomment_id])
      @comments = @comments.paginate(page: 1, per_page: 10)
    end

end