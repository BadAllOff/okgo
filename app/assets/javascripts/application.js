//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require plugins/slimScroll/jquery.slimscroll.min
//= require plugins/fastclick/fastclick.min
//= require plugins/icheck/icheck.min
//= require moment
//= require handlebars-v4.0.5
//= require bootstrap-datetimepicker
//= require bootstrap-slider
//= require md_simple_editor
//= require underscore
//= require gmaps/google
//= require data-confirm-modal
//= require iziToast
//= require msdropdown/jquery.dd.min
//= require app


var ready;

ready = function () {
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

    $(".like-btn").on("ajax:success", function (e, data, status, xhr) {
        var source = $("#eventLikeBtnTemplate").html();
        var template = Handlebars.compile(source);
        var context = {
            btn_class: data.btn_class,
            method: data.method,
            link: data.link,
            likers_count: data.likers_count
        };
        var eventLikeBtn = template(context);
        $('#event_like_btn_' + data.object_id).html("");
        $('#event_like_btn_' + data.object_id).html(eventLikeBtn);
        $('.overlay').addClass('hidden');
    }).on("ajax:error", function (e, xhr, status, error) {
        $('.overlay').addClass('hidden');
    });
//////////////////////////////////////////////////////////////////////////////////////////
    $(document).on("ajax:success","a.event_participation_btn", function (e, data, status, xhr) {
        var context = $.parseJSON(xhr.responseText);

        if (context.status == 'joined')
        {
            var source = $("#eventLeaveBtnTemplate").html();
            var template = Handlebars.compile(source);
            var eventLeaveBtn = template(context);
            //if you REMOVE element, ajax:complete will not trigger. It's better to hide it
            $('.event_join_btn_'+context.event_id+' .event_participation_btn').addClass('hide').append(eventLeaveBtn);
            $('.event_join_btn_'+context.event_id).append(eventLeaveBtn);
            iziToast.success({
                message: context.flash_msg
            });
        }
        else if (context.status == 'leaved')
        {
            var source = $("#eventJoinBtnTemplate").html();
            var template = Handlebars.compile(source);
            var eventJoinBtn = template(context);
            //if you REMOVE element, ajax:complete will not trigger. It's better to hide it
            $('.event_join_btn_'+context.event_id+' .event_participation_btn').addClass('hide').append(eventJoinBtn);
            $('.event_join_btn_'+context.event_id).append(eventJoinBtn);
            iziToast.success({
                message: context.flash_msg
            });
        }
        else if (context.status == 'warning')
        {
            // var source = $("#alertWarningTemplate").html();
            // var template = Handlebars.compile(source);
            // var alertWarning = template(context);
            // $('.flash_messages').append(alertWarning);
            iziToast.error({
                message: context.flash_msg
            });
        }
    });

/////////////////////////////////////////////////////////////////////////////////////////////

    // Show members on TUTOR page
    $('.load-members-btn').bind("ajax:success", function (e, data, status, xhr) {
        var eventId = $(this).context.dataset.eventId;
        $('#event-'+eventId).find('.box-body').append(data);
        $(this).addClass('disabled');
    });

    $('.load_members').bind("ajax:success", function (e, data, status, xhr) {
        // alert('success');
        $(this).addClass('disabled');
        var source = $("#eventMembersTemplate").html();
        var template = Handlebars.compile(source);
        var context = $.parseJSON(xhr.responseText);
        var eventMembers = template(context);
        $('.members_list_'+context.event_id).append(eventMembers);
    }).bind("ajax:error", function (e, data, status, xhr) {
        alert('error');
    });

    function compileEventLikeBtnTemplate() {
        eventLikebtnSource = $("#eventLikeBtnTemplate").html();
        if (eventLikebtnSource !== undefined) {
            eventLikebtnSource = Handlebars.compile(eventLikebtnSource);
        }
    }
    function compileEventMembersTemplate() {
        eventMembersSource = $("#eventMembersTemplate").html();
        if (eventMembersSource !== undefined) {
            eventMembersSource = Handlebars.compile(eventMembersSource);
        }
    }
    function compileEventJoinBtnTemplate() {
        eventJoinBtnSource = $("#eventJoinBtnTemplate").html();
        if (eventJoinBtnSource !== undefined) {
            eventJoinBtnSource = Handlebars.compile(eventJoinBtnSource);
        }
    }
    function compileEventLeaveBtnTemplate() {
        eventLeaveBtnSource = $("#eventLeaveBtnTemplate").html();
        if (eventLeaveBtnSource !== undefined) {
            eventLeaveBtnSource = Handlebars.compile(eventLeaveBtnSource);
        }
    }
    function compileAlertInfoTemplate() {
        alertInfoSource = $("#alertInfoTemplate").html();
        if (alertInfoSource !== undefined) {
            alertInfoSource = Handlebars.compile(alertInfoSource);
        }
    }
    function compileAlertWarningTemplate() {
        alertWarningSource = $("#alertWarningTemplate").html();
        if (alertWarningSource !== undefined) {
            alertWarningSource = Handlebars.compile(alertWarningSource);
        }
    }

    $(document).on("ajax:before", function(){$('.overlay').toggleClass('hidden');});
    $(document).on("ajax:complete", function(xhr, status){$('.overlay').toggleClass('hidden');});
    $(document).on("ajax:error",function(xhr, status){$('.overlay').toggleClass('hidden');});

};
// Comments ///////////////////////////////////////////////////////////////////////////////////////
$(document).on('ajax:success', '.create_new_comment', function(e, data, status, xhr) {
    var source = $("#commentTemplate").html();
    var context = $.parseJSON(xhr.responseText);
    var template = Handlebars.compile(source);
    var commentBox = template(context);
    $(this).closest('.box-comment').before(commentBox);
});
$(document).on("ajax:error", '.create_new_comment', function (e, xhr, status, error) {
    var context = $.parseJSON(xhr.responseText);
    iziToast.error({
        message: context.flash_msg
    });
    $('.overlay').addClass('hidden');
});

$(document).on('ajax:success', '.destroy_comment', function(e, data, status, xhr) {
    var context = $.parseJSON(xhr.responseText);
    $(this).closest('.box-comment').slideUp();
    iziToast.success({
        message: context.flash_msg
    });
});

//  end of Comments ////////////////////////////////////////////////////////////////////////////////

//
$(document).ready(ready);
$(document).on('page:load', ready);
$(document).on('page:update', ready);

