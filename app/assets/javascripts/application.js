//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
// Slimscroll and FastClick plugins. Both of these plugins are recommended to enhance the
// user experience. Slimscroll is required when using the fixed layout.
//= require plugins/slimScroll/jquery.slimscroll.min
//= require plugins/fastclick/fastclick.min
//= require plugins/icheck/icheck.min
//= require moment
//= require bootstrap-datetimepicker
//= require app

$(document).ready(function(){
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
});