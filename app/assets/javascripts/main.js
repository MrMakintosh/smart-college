$('.spoiler > h2').mouseup(function (e) {

    // Targetting the element that we clicked,
    // not all (i.e nested spoilers are included if not selected this way)
    var content = $($(this).parent().children()[1]);
    if (content.hasClass('hidden')) {

        // Value of the element's current height
        var currentHeight;

        // Set the element's height to auto so we can retrieve the height to animate to
        content.css({'height': 'auto'});
        currentHeight = content.height();
        content.height(0); // Immediately set the height to 0 for the initial animation

        // Show the content that was hidden in the divider
        content.removeClass('hidden');
        // Animate to the divider's current height plus 'x'px for a bouncing effect
        content.animate({
            'height': (currentHeight + 8) + 'px'
        }, 'ease-out', function () { // Transition type; speed of animation
            // After animating the bouncing part, delay the animation that fixes the element's height
            setTimeout(function () {
                content.animate({
                    'height': currentHeight + 'px'
                }, 200, function () { // Animate for 'x' milliseconds
                    // After all the animations, set the height to auto
                    // for nested spoilers or other element's that dynamically resize
                    content.css({'height': 'auto'});
                });
            }, 60); // Delay time
        });

    } else {

        // The element's current height
        var currentHeight = content.height();
        // Animate the divider's current height + 'x'px for a bouncing effect
        content.animate({
            'height': (currentHeight + 8) + 'px'
        }, 200, function () { // Animate for 'x' milliseconds
            // After animating the bouncing effect, delay this next animation
            setTimeout(function () {
                content.animate({
                    // A 'slide-up' animation
                    'height': '0'
                }, 'ease-out', function () { // Transition type
                    // After the 'slide-up animation'
                    content.addClass('hidden');  // Hide the spoiler content
                });
            }, 60);
        });

    }
});