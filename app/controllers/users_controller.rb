class UsersController < ApplicationController

  def profile
    @department = Department.all
  end

  ## Method for printing to Excel file via Spreadsheet
  def print
    @students = Student.all
    @passes_affirmative = Array.new
    @passes_negative = Array.new
    @group = params[:group]
    @groups = Group.all
    affirmative = 0
    negative = 0
    if [1,2,3,4,5,6].include? Time.now.month
      year = [Time.now.year - 1, Time.now.year]
    end
    @month = params[:month].to_i
    if params[:date_of] == "0" and params[:date_for] == "0"
      if [10, 12].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[0]}".to_date
        date_for = "31.#{params[:month]}.#{year[0]}".to_date
      elsif [9, 11].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[0]}".to_date
        date_for = "30.#{params[:month]}.#{year[0]}".to_date
      elsif params[:month].to_i == 2
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "28.#{params[:month]}.#{year[1]}".to_date
      elsif [1, 3, 5].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "31.#{params[:month]}.#{year[1]}".to_date
      elsif [4, 6].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "30.#{params[:month]}.#{year[1]}".to_date
      end
    else
      date_of = params[:date_of].to_date
      date_for = params[:date_for].to_date
    end
    @students.each do |student|
      student.passes.each do |pass|
        if (date_of..date_for).include? pass.date_of
          if pass.cause == "1"
            affirmative = affirmative + pass.hours
          else
            negative = negative + pass.hours
          end
        end
      end
      @passes_affirmative[student.id] = affirmative
      @passes_negative[student.id] = negative
      affirmative = 0
      negative = 0
    end
    if params[:group] == "0"
      @students.each do |student|
        student.passes.each do |pass|
          if (date_of..date_for).include? pass.date_of
            if pass.cause == "1"
              affirmative = affirmative + pass.hours
            else
              negative = negative + pass.hours
            end
          end
        end
        @passes_affirmative[student.id] = affirmative
        @passes_negative[student.id] = negative
        affirmative = 0
        negative = 0
      end
      k =0
      studs = []
      @students.each do |student|
        studs[k] = Hash.new
        studs[k][:id] = student.id
        studs[k][:fio] = "#{student.surname} #{student.name} #{student.fathername}"
        studs[k][:group] = student.group.number
        studs[k][:passes_n] = @passes_negative[student.id]
        studs[k][:passes_a] = @passes_affirmative[student.id]
        studs[k][:passes_all] = @passes_affirmative[student.id] + @passes_negative[student.id]
        k = k + 1
      end
      studs = studs.sort_by { |k| k[:passes_n] }
      studs = studs.reverse!
    else
      @groups.each do |group|
        group.students.each do |student|
          student.passes.each do |pass|
            if (date_of..date_for).include? pass.date_of
              if pass.cause == "1"
                affirmative = affirmative + pass.hours
              else
                negative = negative + pass.hours
              end
            end
          end
          @passes_affirmative[group.id] = affirmative
          @passes_negative[group.id] = negative
          affirmative = 0
          negative = 0
        end
      end
      k = 0
      groups = []
      @groups.each do |group|
        groups[k] = Hash.new
        groups[k][:id] = group.id
        groups[k][:number] = group.number
        groups[k][:passes_n] = @passes_negative[group.id]
        groups[k][:passes_a] = @passes_affirmative[group.id]
        groups[k][:passes_all] = @passes_affirmative[group.id] + @passes_negative[group.id]
        k = k + 1
      end
      groups = groups.sort_by { |k| k[:passes_n] }
      groups = groups.reverse!
    end
    sum_a = 0
    sum_n = 0
    sum_all = 0
    if params[:group] == "0"
      @book = Spreadsheet::Workbook.new
      @sheet = @book.create_worksheet :name => "Рейтинг за #{params[:month]}"
      @sheet.row(1).push "№", "ФИО", "Группа", "Пропуски по уважительной причине", "Пропуски по неуважительной причине", "Всего", "Примечание"
      @sheet.row(1).height = 20
      @sheet.row(1).default_format = Spreadsheet::Format.new :weight => :bold
      @sheet.column(1).width = 45
      @sheet.column(2).width = 10
      @sheet.column(3).width = 20
      @sheet.column(4).width = 25
      @sheet.column(5).width = 25
      @sheet.column(6).width = 25
      @sheet.column(7).width = 35
      @i = 2
      studs.each do |studs|
        @sheet.row(@i).push "#{@i - 1}", "#{studs[:fio]}", studs[:group], studs[:passes_a], studs[:passes_n], studs[:passes_all]
        @sheet.row(@i).height = 20
        sum_a = sum_a + studs[:passes_a]
        sum_n = sum_n + studs[:passes_n]
        sum_all = sum_all + studs[:passes_all]
        @i += 1
      end
      @sheet.row(@i).push "Всего:"," ", " ",  sum_a, sum_n, sum_all
      @sheet.row(@i).height = 20
    else
      @book = Spreadsheet::Workbook.new
      @sheet = @book.create_worksheet :name => "Рейтинг за #{params[:month]}"
      @sheet.row(1).push "№", "Группа", "Пропуски по уважительной причине", "Пропуски по неуважительной причине", "Всего", "Примечание"
      @sheet.row(1).height = 20
      @sheet.row(1).default_format = Spreadsheet::Format.new :weight => :bold
      @sheet.column(1).width = 10
      @sheet.column(2).width = 10
      @sheet.column(3).width = 25
      @sheet.column(4).width = 25
      @sheet.column(5).width = 25
      @sheet.column(6).width = 35
      @i = 2
      groups.each do |groups|
        @sheet.row(@i).push "#{@i - 1}", "#{groups[:number]}", groups[:passes_a], groups[:passes_n], groups[:passes_all]
        @sheet.row(@i).height = 20
        sum_a = sum_a + groups[:passes_a]
        sum_n = sum_n + groups[:passes_n]
        sum_all = sum_all + groups[:passes_all]
        @i += 1
      end
      @sheet.row(@i).push "Всего:"," ",  sum_a, sum_n, sum_all
      @sheet.row(@i).height = 20
    end
    @book.write "#{Rails.root}/public/report.xls"
    send_file "#{Rails.root}/public/report.xls", type: 'application/excel', disposition: 'attachment'
  end

  def ratings
    @department = Department.all
    @students = Student.all
    @passes_affirmative = Array.new
    @passes_negative = Array.new
    @group = params[:group]
    @groups = Group.all
    affirmative = 0
    negative = 0
    if [1,2,3,4,5,6].include? Time.now.month
      year = [Time.now.year - 1, Time.now.year]
    end
    @month = params[:month].to_i
    if params[:date_of] == "0" and params[:date_for] == "0"
      if [10, 12].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[0]}".to_date
        date_for = "31.#{params[:month]}.#{year[0]}".to_date
      elsif [9, 11].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[0]}".to_date
        date_for = "30.#{params[:month]}.#{year[0]}".to_date
      elsif params[:month].to_i == 2
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "28.#{params[:month]}.#{year[1]}".to_date
      elsif [1, 3, 5].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "31.#{params[:month]}.#{year[1]}".to_date
      elsif [4, 6].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "30.#{params[:month]}.#{year[1]}".to_date
      end
    else
      date_of = params[:date_of].to_date
      date_for = params[:date_for].to_date
    end
    if params[:group] == "0"
      @students.each do |student|
        student.passes.each do |pass|
          if (date_of..date_for).include? pass.date_of
            if pass.cause == "1"
              affirmative = affirmative + pass.hours
            else
              negative = negative + pass.hours
            end
          end
        end
        @passes_affirmative[student.id] = affirmative
        @passes_negative[student.id] = negative
        affirmative = 0
        negative = 0
      end
    else
      @groups.each do |group|
        group.students.each do |student|
          student.passes.each do |pass|
            if (date_of..date_for).include? pass.date_of
              if pass.cause == "1"
                affirmative = affirmative + pass.hours
              else
                negative = negative + pass.hours
              end
            end
          end
          @passes_affirmative[group.id] = affirmative
          @passes_negative[group.id] = negative
          affirmative = 0
          negative = 0
        end
      end
    end
    @date_of = date_of
    @date_for = date_for
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update users_params
      redirect_to users_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def users_params
    params.require(:user).permit(:login, :password, :password_confirmation, :admin, :name, :surname, :position)
  end

end
