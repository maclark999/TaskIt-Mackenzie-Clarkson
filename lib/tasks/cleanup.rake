namespace :clean do
  task :memberships_users_remove => :environment do
    Membership.all.each do |member|
      if member.user.nil?
        member.destroy
      end
    end
  end

  task :memberships_projects_remove => :environment do
    Membership.all.each do |member|
      if member.project.nil?
        member.destroy
      end
    end
  end

  task :tasks_projects_remove => :environment do
    Task.all.each do |task|
      if task.project.nil?
        task.destroy
      end
    end
  end

  task :comments_tasks_remove => :environment do
    Comment.all.each do |comment|
      if comment.task.nil?
        comment.destroy
      end
    end
  end

  task :sets_user_id => :environment do
    Comment.all.each do |comment|
      if comment.user.nil?
        comment.user_id = nil
        comment.save
      end
    end
  end

  task :tasks_project_id_remove => :environment do
    Task.all.each do |task|
      if task.project_id.nil?
        task.destroy
      end
    end
  end

  task :comments_task_id_remove => :environment do
    Comment.all.each do |comment|
      if comment.task_id.nil?
       comment.destroy
      end
    end
  end

  task :memberships_ids_null_remove => :environment do
    Membership.all.each do |membership|
      if membership.project_id.nil? || membership.task_id.nil?
        membership.destroy
      end
    end
  end
end
