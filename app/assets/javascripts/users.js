
$(document).ready(function(){
    var output="<table class='students' border='1'><tr><th>№</th><th>ФИО</th><th>Адрес</th><th>Пропуски (Уважительные)</th><th>Пропуски (Неуважительные)</th><th colspan='2'>Отметить отсутствующих</th>";
    $.ajax({
      type: 'GET',
      url: "/api_request/1",
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
});

$("#group").change(function () {
    var output="<table class='students' border='1'><tr><th>№</th><th>ФИО</th><th>Адрес</th><th>Пропуски (Уважительные)</th><th>Пропуски (Неуважительные)</th><th colspan='2'>Отметить отсутствующих</th>";
    $.ajax({
      type: 'GET',
      url: "/api_request/"+$("#group").val(),
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
});

function causeCheck(i){
  var cause = document.getElementsByName('cause_check[]');
  if(cause[i-1].checked){
    $("#cause"+i).prop("value", "1");
  }
  else{
    $("#cause"+i).prop("value", "0");
  }
}

function passButtonClick (form) {
    $.ajax({
        type: 'GET',
        url: "/add_pass/"+form.student.value+"/"+form.hours.value+"/"+form.cause.value,
        dataType: 'json',
        success: function (data) {
            var ajaxUrl = "";
            alert("Пропуск зарегистрирован!");
            var output="<table class='students' border='1'><tr><th>№</th><th>ФИО</th><th>Адрес</th><th>Пропуски (Уважительные)</th><th>Пропуски (Неуважительные)</th><th colspan='2'>Отметить отсутствующих</th>";
            if ($("#search").val().length > 2){
                ajaxUrl = "/search/"+$("#search").val();
            }
            else{
                ajaxUrl = "/api_request/"+$("#group").val();
            }
            $.ajax({
                type: 'GET',
                url: ajaxUrl,
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

$("#search").keyup(function() {
    var value = $( this ).val();
    if(value.length > 2){
      $.ajax({
          type: 'GET',
          url: "/search/"+value,
          dataType: 'json',
          success: function (data) {
            if(data.students[0]) {
                var output="<table class='students' border='1'><tr><th>№</th><th>ФИО</th><th>Группа</th><th>Адрес</th><th>Пропуски (Уважительные)</th><th>Пропуски (Неуважительные)</th><th colspan='2'>Отметить отсутствующих</th>";
                var j = 1;
                for(var i = 0; i < data.students.length; i++){
                  output += output_for_table({"students":data.students[i], "passes_affirmative":data.passes_affirmative, "passes_negative":data.passes_negative}, j, 1);
                  j += 1;
                }
                output += "</table>";
            }
            else{
                var output = "Ничего не найдено..."
            }
            $("#result").html(output);
          }
      })
    }
    else{
      var output="<table class='students' border='1'><tr><th>№</th><th>ФИО</th><th>Адрес</th><th>Пропуски (Уважительные)</th><th>Пропуски (Неуважительные)</th><th colspan='2'>Отметить отсутствующих</th>";
      $.ajax({
        type: 'GET',
        url: "/api_request/"+$("#group").val(),
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
});