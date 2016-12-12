//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
// Slimscroll and FastClick plugins. Both of these plugins are recommended to enhance the
// user experience. Slimscroll is required when using the fixed layout.
//= require plugins/slimScroll/jquery.slimscroll.min
//= require plugins/fastclick/fastclick.min
//= require plugins/icheck/icheck.min
//= require moment
//= require handlebars-v4.0.5
//= require bootstrap-datetimepicker
//= require md_simple_editor
//= require app
var ready;

$(document).ready(function() {
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue'
    });

    $(function () {
        $('#datetimepicker1').datetimepicker({
            format: "YYYY-MM-DD HH:mm"
        });
        $('#datetimepicker2').datetimepicker({
            format: "YYYY-MM-DD HH:mm",
            useCurrent: false //Important! See issue #1075
        });
        $("#datetimepicker1").on("dp.change", function (e) {
            $('#datetimepicker2').data("DateTimePicker").minDate(e.date);
        });
        $("#datetimepicker2").on("dp.change", function (e) {
            $('#datetimepicker1').data("DateTimePicker").maxDate(e.date);
        });
    });

    $(".like-btn").on("ajax:success", function(e, data, status, xhr) {
        var source   = $("#eventLikeBtnTemplate").html();
        var template = Handlebars.compile(source);
        var context = {
            btn_class: data.btn_class,
            method: data.method,
            link: data.link,
            likers_count: data.likers_count
        };
        var eventLikeBtn = template(context);
        $('#event_like_btn_'+data.object_id).html("");
        $('#event_like_btn_'+data.object_id).html(eventLikeBtn);
    }).on("ajax:error", function(e, xhr, status, error) {
        console.log('error like btn');
    });

    function compileEventLikeBtnTemplate(){
        eventLikebtnSource = $("#eventLikeBtnTemplate").html();
        if ( eventLikebtnSource !== undefined ) {
            eventLikebtnSource = Handlebars.compile(eventLikebtnSource);
        }
    }

    function compileEventUnlikeBtnTemplate(){
        eventUnlikebtnSource = $("#eventUnlikeBtnTemplate").html();
        if ( eventUnlikebtnSource !== undefined ) {
            eventUnlikebtnSource = Handlebars.compile(eventUnlikebtnSource);
        }
    }

});
//
// $(document).ready(ready);
// $(document).on('page:load', ready);
// $(document).on('page:update', ready);

