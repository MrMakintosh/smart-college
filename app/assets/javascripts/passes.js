function passButtonClickPass(form, date_of, date_for) {
    if(form.affirmative_hours.value == "") {
        form.affirmative_hours.value = "0";
    }
    if(form.negative_hours.value == ""){
        form.negative_hours.value = "0";
    }
    $.ajax({
        type: 'GET',
        url: "/add_pass/"+form.student.value+"/"+form.affirmative_hours.value+"/"+form.negative_hours.value+"/"+date_of+"/"+date_for,
        dataType: 'json',
        success: function (data) {
            $("#notice").html("<div style='width:20%;border-radius:20px;background-color:lightgreen'>Пропуски зачислены учащемуся:"+data.surname+" "+data.name+"</div>")
            var output="<table class='students' border='1'><tr><th>№</th><th>ФИО</th><th>Пропуски (Уважительные)</th><th>Пропуски (Неуважительные)</th><th colspan='2'>Отметить отсутствующих</th>";
            $.ajax({
                type: 'GET',
                url: "/api_request/"+form.student.value+"/"+date_of+"/"+date_for,
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