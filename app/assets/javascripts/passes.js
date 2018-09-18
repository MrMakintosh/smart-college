function passButtonClickPass(form, date_of, date_for) {
    $.ajax({
        type: 'GET',
        url: "/add_pass/"+form.student.value+"/"+form.affirmative_hours.value+"/"+form.negative_hours.value+"/"+date_of+"/"+date_for,
        dataType: 'json',
        success: function (data) {
            $("#notice").html("<div style='width:20%;border-radius:20px;background-color:lightgreen'>"+form.hours.value+"часов добавлено учащемуся:"+form.student+"</div>")
            var result = "<form action='javascript:passButtonClick(this.form)'><table style='width: 100%; text-align: center' border='0'><tr><th>Промежуток от</th><th>Промежуток до</th><th>Учащийся</th><th>Количество часов</th><th colspan='3'>Уважительная причина</th><th></th></tr>";
            result += "<tr><td><input type='date' name='date_of'></td><td><input type='date' name='date_for'></td><td><select name='student' value=''><% @student.each do |student| %><option><%= student.surname %> <%= student.name %> <%= student.fathername %></option><% end %></select></td><td><input type='number' name='hours'></td><td style='width:10%'></td><td><input id='cause' type='checkbox'></td><td></td><td><input type='submit' value='Добавить'></td></tr></form>";
            var result_student = "<table style='width: 100%; text-align: center' border='1'><tr><th colspan='2' rowspan='3'>ФИО</th><th colspan='4'>Месяц: <%= Time.now.month %></th></tr><tr><th colspan='2'>01 - 15</th><th colspan='2'><% if Time.days_in_month(Time.now.month) == 31 %>16 - 31<% else %>16-30<% end %></th></tr><tr><th>Ув</th><th>Не ув</th><th>Ув</th><th>Не ув</th></tr>";
            $("#result").html(result);
            $("#result-student").html(result_student);
            $("#cause").prop("value", 0);
        }
    })
}
function groupButtonClick(id, date_of, date_for) {
    var output="<table class='students' border='1'><tr><th>№</th><th>ФИО</th><th>Пропуски (Уважительные)</th><th>Пропуски (Неуважительные)</th><th colspan='2'>Отметить отсутствующих</th>";
    $.ajax({
        type: 'GET',
        url: "/api_request/"+id+"/"+date_of+"/"+date_for,
        dataType: 'json',
        success: function (data) {
            var j = 1;
            for(var i = 0; i < data.students.length; i++){
                output += output_for_table({"students":data.students[i], "passes_affirmative":data.passes_affirmative, "passes_negative":data.passes_negative}, j, 0);
                j += 1;
            }
            output += "</table>";
            $("#result").html(output);
        }
    })
}