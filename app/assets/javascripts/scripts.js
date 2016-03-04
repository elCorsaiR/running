var chart_hash = {};
$(document).ready(function(){
	'use strict';

	/* Facebook share modal */
    if (typeof(FB) != 'undefined'
        && FB != null ) {
        FB.init({
            appId: 'YOUR APP ID', //You must replace the value in 'YOUR APP ID' with the ID of your own Facebook App
            status: true, // check login status
            cookie: true, // enable cookies to allow the server to access the session
            xfbml: true, // parse XFBML
            channelUrl: 'http://WWW.MYDOMAIN.COM/channel.html', // channel.html file
            oauth: true // enable OAuth 2.0
        });
    }

	var linkToShare = 'https://developers.facebook.com/docs/';
    var currentSectionName = null;

    $('.share-popup').click(function(event) {
        var url_str = this.href;
        if ($(this).data("text") != ""){
            url_str += "?text=" + $(this).data("text")
        }
        var width  = 575,
            height = 500,
            left   = ($(window).width()  - width)  / 2,
            top    = ($(window).height() - height) / 2,
            url    = url_str,
            opts   = 'status=1' +
                ',width='  + width  +
                ',height=' + height +
                ',top='    + top    +
                ',left='   + left;

        window.open(url, 'share', opts);

        return false;
    });

	$('.slider').slick({
		arrows: true,
		variableWidth: true,
		responsive: [
	    {
	      breakpoint: 1024,
	      settings: {
	        variableWidth: false,
	        arrows: true
	      }
	    }]
	});

	$('.js-open').on('click', function(e){
		e.preventDefault();
		$('.dropdown-content').slideToggle();
	});

	$('.client-row').on('click', function(){
		//$(this).find('.client-list-checkbox').click();
        var url = $(this).find('.client-list-link').val();
        if ((typeof(url) != 'undefined' ) && (url != "")) {
            window.location.href = url;
        }
	});

    $('.client-row .client-list-checkbox').click(function(e){
        e.stopPropagation();
    });

    $('.show_left').on('click', function(e){
        e.preventDefault();
        $(this).removeClass("gray");
        $(this).addClass("orange");

        $(this).parent().find(".show_right").removeClass("orange");
        $(this).parent().find(".show_right").addClass("gray");

        $(this).parent().parent().find('.chartright').hide();
        $(this).parent().parent().find('.chartleft').show();
        //$(this).parent().parent().find('.chartleft').each(function(){
        //    chart_hash[this.id].update();
        //});
    });

    $('.show_right').on('click', function(e){
        e.preventDefault();
        $(this).removeClass("gray");
        $(this).addClass("orange");

        $(this).parent().find(".show_left").removeClass("orange");
        $(this).parent().find(".show_left").addClass("gray");

        $(this).parent().parent().find('.chartright').show();
        $(this).parent().parent().find('.chartleft').hide();
        $(this).parent().parent().find('.chartright').each(function(){
            chart_hash[this.id].update();
        });
    });

	$('.facebook-share').on('click', function(e){
		e.preventDefault();
		FB.ui({
		  method: 'share',
		  href: linkToShare
		}, function(response){});
	});



	stickyNav();
	showPopup();
	accordion();
	AddCharts();
    changeHeaderName();
    closeCurrentSection();

    $('.chartright').hide();

});

function accordion() {
	$('.accordion').on('click', function(){

		if( $(this).hasClass('isSlideDown') ) {
			$(this).next('.accordion-open').removeClass('accordion-opened');
			$(this).removeClass('isSlideDown');
            $(this).find('.closed-section').show();
            $(this).find('.opened-section').hide();
            $('.close-current-section').hide();
		} else {
			$(this).next('.accordion-open').addClass('accordion-opened');
			$(this).addClass('isSlideDown');
            $(this).find('.closed-section').hide();
            $(this).find('.opened-section').show();
            if($(currentSectionName).is($(this))) {
                $('.close-current-section').show();
            }
		}
        setTimeout(function(){ changeHeaderName(); }, 100);
	})
}

function showPopup() {
	$('.js-open-popup').on('click', function(e) {
		e.preventDefault();
		$('.popup-wrapper').fadeIn();
	});

	$('.js-close-popup').on('click', function(e) {
		e.preventDefault();
		$('.popup-wrapper').fadeOut();
	});
}

function stickyNav() {
	$(window).scroll(function(){
        if($(window).scrollTop() > 60){
              $('.sticky-nav').fadeIn();
              $('.social-menu').addClass('social-sticky');
        } else {
            $('.sticky-nav').fadeOut();
             $('.social-menu').removeClass('social-sticky');
        }
	});
}

function closeCurrentSection() {
    $('.close-current-section').on('click', function(e){
        e.preventDefault();
        $(currentSectionName).next('.accordion-open').removeClass('accordion-opened');
        $(currentSectionName).removeClass('isSlideDown');
        $(currentSectionName).find('.closed-section').show();
        $(currentSectionName).find('.opened-section').hide();
        $('.close-current-section').hide();

        setTimeout(function(){ changeHeaderName(); }, 100);
    });
}
function changeHeaderName() {
    // $(window).off('scroll');

    var videoPosition = $('.video').offset();
    var prformancePosition = $('.performance').offset();
    var technicalPosition = $('.technical-analysis').offset();
    var anatomyPosition = $('.anatomy').offset();
    var conclusionPosition = $('.conclusion').offset();
    var programmePosition = $('.programme').offset();

    $(window).on('scroll', function(){
        if( ( typeof(videoPosition) != 'undefined' ) && $(window).scrollTop() > videoPosition.top){
            $('.name-of-current-section').text('VÍDEOS DE LA SESIÓN');
            currentSectionName = '.video';
        }
        if (( typeof(prformancePosition) != 'undefined' ) && $(window).scrollTop() > prformancePosition.top) {
            $('.name-of-current-section').text('ÍNDICE DE RENDIMIENTO');
            currentSectionName = '.performance';
        }
        if (( typeof(technicalPosition) != 'undefined' ) && $(window).scrollTop() > technicalPosition.top) {
            $('.name-of-current-section').text('ANÁLISIS TÉCNICO');
            currentSectionName = '.technical-analysis';
        }
        if (( typeof(anatomyPosition) != 'undefined' ) && $(window).scrollTop() > anatomyPosition.top) {
            $('.name-of-current-section').text('EVALUACIÓN ANATÓMICA');
            currentSectionName = '.anatomy';
        }
        if (( typeof(conclusionPosition) != 'undefined' ) && $(window).scrollTop() > conclusionPosition.top) {
            $('.name-of-current-section').text('NUESTRAS CONCLUSIONES');
            currentSectionName = '.conclusion';
        }
        if (( typeof(programmePosition) != 'undefined' ) && $(window).scrollTop() > programmePosition.top) {
            $('.name-of-current-section').text('PROGRAMA DE EJERCICIOS');
            currentSectionName = '.programme';
        }
        if((typeof(currentSectionName) != 'undefined') && $(currentSectionName).hasClass('isSlideDown')){
            $('.close-current-section').show();
        }else{
            $('.close-current-section').hide();
        }
    });
}

function AddCharts() {
	/* Charts */


	AddRadarAndPolarCharts();
	AddDonutCharts();
	AddLinearCharts();
	AddBarCharts();
}

function AddLinearCharts() {

    Chart.types.Line.extend({
        name: "LineAlt",
        intialize: function () {
            Chart.types.Line.intialize.draw.apply(this, arguments);
        },
        draw: function () {
            Chart.types.Line.prototype.draw.apply(this, arguments);

            var ctx = this.chart.ctx;
            ctx.save();
            //ctx.lineWidth = this.scale.lineWidth;
            ctx.lineWidth = this.scale.lineWidth;
            ctx.strokeStyle = 'rgba(0,0,0,.3)';
            ctx.beginPath();
            ctx.moveTo(this.scale.xScalePaddingLeft, this.scale.calculateY(0));
            ctx.lineTo(this.chart.width, this.scale.calculateY(0));
            ctx.stroke();
            ctx.closePath();
            ctx.restore();
        }
    });


    var datal1 = $(".chart1").data("var");
	var chartL1 = $(".chart1").get(0).getContext("2d");
	var myLineChart = new Chart(chartL1).LineAlt(datal1, {
		pointDot : false,
        pointHitDetectionRadius : 4,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %>: <%= value %>",
        scaleShowLabels: false
	});

	var datal2 = $(".chart3").data("var");
	var chartL2 = $(".chart3").get(0).getContext("2d");
	var myLineChart = new Chart(chartL2).LineAlt(datal2, {
		pointDot : false,
        pointHitDetectionRadius : 4,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %>: <%= value %>",
        scaleShowLabels: false
	});

	var datal3 = $(".chart5").data("var");
	var chartL3 = $(".chart5").get(0).getContext("2d");
	var myLineChart = new Chart(chartL3).LineAlt(datal3, {
		pointDot : false,
        pointHitDetectionRadius : 4,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %>: <%= value %>",
        scaleShowLabels: false
	});

	var datal4 = $(".chart7").data("var");
	var chartL4 = $(".chart7").get(0).getContext("2d");
	var myLineChart = new Chart(chartL4).LineAlt(datal4, {
		pointDot : false,
        pointHitDetectionRadius : 4,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %>: <%= value %>",
        scaleShowLabels: false
	});

	var datal5 = $(".chart9").data("var");
	var chartL5 = $(".chart9").get(0).getContext("2d");
	var myLineChart = new Chart(chartL5).LineAlt(datal5, {
		pointDot : false,
        pointHitDetectionRadius : 4,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %>: <%= value %>",
        scaleShowLabels: false
	});

	var datal6 = $(".chart11").data("var");
	var chartL6 = $(".chart11").get(0).getContext("2d");
	var myLineChart = new Chart(chartL6).LineAlt(datal6, {
		pointDot : false,
        pointHitDetectionRadius : 4,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %>: <%= value %>",
        scaleShowLabels: false
	});

	var datal7 = $(".chart13").data("var");
	var chartL7 = $(".chart13").get(0).getContext("2d");
	var myLineChart = new Chart(chartL7).LineAlt(datal7, {
		pointDot : false,
        pointHitDetectionRadius : 4,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %>: <%= value %>",
        scaleShowLabels: false
	});

	var datal8 = $(".chart15").data("var");
	var chartL8 = $(".chart15").get(0).getContext("2d");
	var myLineChart = new Chart(chartL8).LineAlt(datal8, {
		pointDot : false,
        pointHitDetectionRadius : 4,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        multiTooltipTemplate: "<%= datasetLabel %>: <%= value %>",
        scaleShowLabels: false
	});

}

function AddDonutCharts(){


    var dataD1 = $("#performanceChart").data("var");
	var chartD1 = document.getElementById("performanceChart").getContext("2d");
	var myDoughnutChart = new Chart(chartD1).Doughnut(dataD1,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70,
		tooltipTemplate: "<%= value %>%"
	});

    $('.performance-chart__text h4').css('color', $("#performanceChart").data("color"));

	var dataD2 = $("#chart1").data("var");
	var chartD2 = document.getElementById("chart1").getContext("2d");
	var myDoughnutChart = new Chart(chartD2).Doughnut(dataD2,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70,
        tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value %>%"
	});

	var dataD3 = $("#chart2").data("var");
	var chartD3 = document.getElementById("chart2").getContext("2d");
	var myDoughnutChart = new Chart(chartD3).Doughnut(dataD3,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70,
        tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value %>%"
	});

	var dataD4 = $("#chart3").data("var");
	var chartD4 = document.getElementById("chart3").getContext("2d");
	var myDoughnutChart = new Chart(chartD4).Doughnut(dataD4,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70,
        tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value %>%"
	});

	var dataD5 = $("#chart4").data("var");
	var chartD5 = document.getElementById("chart4").getContext("2d");
	var myDoughnutChart = new Chart(chartD5).Doughnut(dataD5,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70,
        tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value %>%"
	});

	var dataD6 = $("#chart5").data("var");
	var chartD6 = document.getElementById("chart5").getContext("2d");
	var myDoughnutChart = new Chart(chartD6).Doughnut(dataD6,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70,
        tooltipTemplate: "<%if (label){%><%=label%>: <%}%><%= value %>%"
	});

    $(".anatomy1").each(function() {
        var dataOptimo = $( this ).data("var");
        var chartOptimo = $( this ).get(0).getContext("2d");
        var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataOptimo,{
            segmentShowStroke : false,
            animateRotate : false,
            percentageInnerCutout : 80,
            showTooltips: false
        });
        chart_hash[this.id] = myDoughnutChart;
        $(this).prev('.down:first').text(dataOptimo[1].label);
    });

}

function AddRadarAndPolarCharts() {
    var performanceRadarChart = $("#performanceRadarChart");
    if (performanceRadarChart.length) {
        var dataR1 = performanceRadarChart.data("var");
        var chartR1 = performanceRadarChart.get(0).getContext("2d");
        var myRadarChart = new Chart(chartR1).Radar(dataR1, {
            scaleShowLine: false,
            tooltipTemplate: "<%= value %>%"
        });
    }

    $('.chart-a1').each(function(){
        var dataP1 = $(this).data("var");

        var chart_a1 = $(this);
            var chartP1 = chart_a1.get(0).getContext("2d");
            var chartPolar1 = new Chart(chartP1).PolarArea(dataP1, {
                segmentStrokeWidth: 4,
                scaleOverride : true,
                scaleSteps : 3,
                scaleStepWidth : 1,
                scaleStartValue : 0,
                scaleLabel: function (value) {
                    var res;
                    switch (Number(value.value)) {
                        case 0:
                        case 1:
                            res = 'bajo';
                            break;
                        case 2:
                            res = 'aceptable';
                            break;
                        case 3:
                            res = 'óptimo';
                            break;
                        default:
                            res = '';
                    }
                    return res;
                },
                tooltipTemplate:function (value, label) {
                    var res;
                    switch (Number(value.value)) {
                        case 0:
                        case 1:
                            res = 'bajo';
                            break;
                        case 2:
                            res = 'aceptable';
                            break;
                        case 3:
                            res = 'óptimo';
                            break;
                        default:
                            res = '';
                    }
                    return value.label + ': ' + res;
                }
            });
        chart_hash[this.id] = chartPolar1;
    });

    //var dataP1 = $(".chart-a1").data("var");
    //
    //var chart_a1 = $(".chart-a1");
    //if (chart_a1.length) {
    //    var chartP1 = chart_a1.get(0).getContext("2d");
    //    var chartPolar1 = new Chart(chartP1).PolarArea(dataP1, {
    //        segmentStrokeWidth: 4
    //    });
    //}

}


function AddBarCharts() {

	var dataB1 = $("#chart6").data("var");

	BarWidth();

    tooltip = "<%if (value >= 6.5){%><%='exceso'%><%}else if(value >= 3.5){%><%='óptimo'%><%} else %><%='escaso'%>";

	var chartB1 = document.getElementById("chart6").getContext("2d");
	var chartBar1 = new Chart(chartB1).BarAlt(dataB1, {
        showTooltips: true,
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false
    });


	var dataB2 = $(".chart2").data("var");
	var chartB2 = $(".chart2").get(0).getContext("2d");
	var chartBar2 = new Chart(chartB2).BarAlt(dataB2, {
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false,
        limitLines: [
            {
                label: 'max',
                value: 3.5,
                color: '#A8A9A9'
            },
            {
                label: 'min',
                value: 6.5,
                color: '#A8A9A9'
            }
        ]
    });

	var dataB3 =$(".chart4").data("var");
	var chartB3 = $(".chart4").get(0).getContext("2d");
	var chartBar3 = new Chart(chartB3).BarAlt(dataB3, {
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false,
        limitLines: [
            {
                label: 'max',
                value: 3.5,
                color: '#A8A9A9'
            },
            {
                label: 'min',
                value: 6.5,
                color: '#A8A9A9'
            }
        ]
    });


	var dataB4 = $(".chart6").data("var");
	var chartB4 = $(".chart6").get(0).getContext("2d");
	var chartBar4 = new Chart(chartB4).BarAlt(dataB4, {
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false,
        limitLines: [
            {
                label: 'max',
                value: 3.5,
                color: '#A8A9A9'
            },
            {
                label: 'min',
                value: 6.5,
                color: '#A8A9A9'
            }
        ]
    });


	var dataB5 = $(".chart8").data("var");
	var chartB5 = $(".chart8").get(0).getContext("2d");
	var chartBar5 = new Chart(chartB5).BarAlt(dataB5, {
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false,
        limitLines: [
            {
                label: 'max',
                value: 3.5,
                color: '#A8A9A9'
            },
            {
                label: 'min',
                value: 6.5,
                color: '#A8A9A9'
            }
        ]
    });


	var dataB6 = $(".chart10").data("var");
	var chartB6 = $(".chart10").get(0).getContext("2d");
	var chartBar6 = new Chart(chartB6).BarAlt(dataB6, {
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false,
        limitLines: [
            {
                label: 'max',
                value: 3.5,
                color: '#A8A9A9'
            },
            {
                label: 'min',
                value: 6.5,
                color: '#A8A9A9'
            }
        ]
    });



	var dataB7 = $(".chart12").data("var");
	var chartB7 = $(".chart12").get(0).getContext("2d");
	var chartBar7 = new Chart(chartB7).BarAlt(dataB7, {
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false,
        limitLines: [
            {
                label: 'max',
                value: 3.5,
                color: '#A8A9A9'
            },
            {
                label: 'min',
                value: 6.5,
                color: '#A8A9A9'
            }
        ]
    });



	var dataB8 = $(".chart14").data("var");
	var chartB8 = $(".chart14").get(0).getContext("2d");
	var chartBar8 = new Chart(chartB8).BarAlt(dataB8, {
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false,
        limitLines: [
            {
                label: 'max',
                value: 3.5,
                color: '#A8A9A9'
            },
            {
                label: 'min',
                value: 6.5,
                color: '#A8A9A9'
            }
        ]
    });



	var dataB9 = $(".chart16").data("var");
	var chartB9 = $(".chart16").get(0).getContext("2d");
	var chartBar9 = new Chart(chartB9).BarAlt(dataB9, {
        tooltipFillColor: "rgba(0,0,0,0.8)",
        scaleOverride : true,
        scaleSteps : 9,
        scaleStepWidth : 1,
        scaleStartValue : 0,
        multiTooltipTemplate: "<%= datasetLabel %>: "+tooltip,
        scaleShowLabels: false,
        limitLines: [
            {
                label: 'max',
                value: 3.5,
                color: '#A8A9A9'
            },
            {
                label: 'min',
                value: 6.5,
                color: '#A8A9A9'
            }
        ]
    });


}

function BarWidth() {
    Chart.types.Bar.extend({
        name: "BarAlt",
        initialize:  function(data) {

            //Expose options as a scope variable here so we can access it in the ScaleClass
            Chart.types.Bar.prototype.initialize.apply(this, arguments);

            var options = this.options;

            this.ScaleClass = Chart.Scale.extend({
                offsetGridLines : true,
                calculateBarX : function(datasetCount, datasetIndex, barIndex){
                    //Reusable method for calculating the xPosition of a given bar based on datasetIndex & width of the bar
                    var xWidth = this.calculateBaseWidth(),
                        xAbsolute = this.calculateX(barIndex) - (xWidth/2),
                        barWidth = this.calculateBarWidth(datasetCount);

                    var oldWidth = (this.calculateBaseWidth() - ((datasetCount - 1) * options.barDatasetSpacing)) / datasetCount;
                    return xAbsolute + (oldWidth * datasetIndex) + (datasetIndex * options.barDatasetSpacing) + oldWidth/2
                        ;
                },
                calculateBaseWidth : function(){
                    return (this.calculateX(1) - this.calculateX(0)) - (2*options.barValueSpacing);
                },
                calculateBarWidth : function(datasetCount){
                    //The padding between datasets is to the right of each bar, providing that there are more than 1 dataset
                    //var baseWidth = this.calculateBaseWidth() - ((datasetCount - 1) * options.barDatasetSpacing);

                    return 26;// (baseWidth / datasetCount);
                }
            });
            this.buildScale(data.labels);
        },
        draw: function(){

            this.options.barValueSpacing = 5;//this.chart.width / 7;
            Chart.types.Bar.prototype.draw.apply(this, arguments);

            var lines = this.options.limitLines;

            for (var i = lines.length; --i >= 0;) {

                var xStart = Math.round(this.scale.xScalePaddingLeft);
                var linePositionY = this.scale.calculateY(lines[i].value);

                this.chart.ctx.fillStyle = lines[i].color ? lines[i].color : this.scale.textColor;
                this.chart.ctx.font = this.scale.font;
                this.chart.ctx.textAlign = "left";
                this.chart.ctx.textBaseline = "top";

                if (this.scale.showLabels && lines[i].label) {
                    this.chart.ctx.fillText(lines[i].label, xStart + 5, linePositionY);
                }

                this.chart.ctx.lineWidth = this.scale.gridLineWidth;
                this.chart.ctx.strokeStyle = lines[i].color ? lines[i].color : this.scale.gridLineColor;

                this.chart.ctx.setLineDash([10, 10]);
                if (this.scale.showHorizontalLines) {
                    this.chart.ctx.beginPath();
                    this.chart.ctx.moveTo(xStart, linePositionY);
                    this.chart.ctx.lineTo(this.scale.width, linePositionY);
                    this.chart.ctx.stroke();
                    this.chart.ctx.closePath();
                }
                this.chart.ctx.lineWidth = this.lineWidth;
                this.chart.ctx.strokeStyle = this.lineColor;
                this.chart.ctx.beginPath();
                this.chart.ctx.moveTo(xStart - 5, linePositionY);
                this.chart.ctx.lineTo(xStart, linePositionY);
                this.chart.ctx.stroke();
                this.chart.ctx.closePath();
                this.chart.ctx.setLineDash([]);
            }
        }
    });

    Chart.types.Bar.extend({
        name: "BarAlt2",
        draw: function(){
            this.options.barValueSpacing = this.chart.width / 3;
            Chart.types.Bar.prototype.draw.apply(this, arguments);
        }
    });
    Chart.types.Bar.extend({
        name: "BarAlt3",
        draw: function(){
            this.options.barValueSpacing = this.chart.width / 2;
            Chart.types.Bar.prototype.draw.apply(this, arguments);
        }
    });
}


function BarChartsWidth() {
		Chart.types.Bar.extend({

	    name: "BarWidth",
	    // all blocks that don't have a comment are a direct copy paste of the Chart.js library code
	    initialize: function (data) {

	        // the sum of all widths
	        var widthSum = data.datasets[0].data2.reduce(function (a, b) { return a + b }, 0);
	        // cumulative sum of all preceding widths
	        var cumulativeSum = [ 0 ];
	        data.datasets[0].data2.forEach(function (e, i, arr) {
	            cumulativeSum.push(cumulativeSum[i] + e);
	        });


	        var options = this.options;

	        // completely rewrite this class to calculate the x position and bar width's based on data2
	        this.ScaleClass = Chart.Scale.extend({
	            offsetGridLines: true,
	            calculateBarX: function (barIndex) {
	                var xSpan = this.width - this.xScalePaddingLeft;
	                var x = this.xScalePaddingLeft + (cumulativeSum[barIndex] / widthSum * xSpan) - this.calculateBarWidth(barIndex) / 2;
	                return x + this.calculateBarWidth(barIndex);
	            },
	            calculateBarWidth: function (index) {
	                var xSpan = this.width - this.xScalePaddingLeft;
	                return (xSpan * data.datasets[0].data2[index] / widthSum);
	            }
	        });

	        this.datasets = [];

	        if (this.options.showTooltips) {
	            Chart.helpers.bindEvents(this, this.options.tooltipEvents, function (evt) {
	                var activeBars = (evt.type !== 'mouseout') ? this.getBarsAtEvent(evt) : [];

	                this.eachBars(function (bar) {
	                    bar.restore(['fillColor', 'strokeColor']);
	                });
	                Chart.helpers.each(activeBars, function (activeBar) {
	                    activeBar.fillColor = activeBar.highlightFill;
	                    activeBar.strokeColor = activeBar.highlightStroke;
	                });
	                this.showTooltip(activeBars);
	            });
	        }

	        this.BarClass = Chart.Rectangle.extend({
	            strokeWidth: this.options.barStrokeWidth,
	            showStroke: this.options.barShowStroke,
	            ctx: this.chart.ctx
	        });

	        Chart.helpers.each(data.datasets, function (dataset, datasetIndex) {

	            var datasetObject = {
	                label: dataset.label || null,
	                fillColor: dataset.fillColor,
	                strokeColor: dataset.strokeColor,
	                bars: []
	            };

	            this.datasets.push(datasetObject);

	            Chart.helpers.each(dataset.data, function (dataPoint, index) {
	                datasetObject.bars.push(new this.BarClass({
	                    value: dataPoint,
	                    label: data.labels[index],
	                    datasetLabel: dataset.label,
	                    strokeColor: dataset.strokeColor,
	                    fillColor: dataset.fillColor,
	                    highlightFill: dataset.highlightFill || dataset.fillColor,
	                    highlightStroke: dataset.highlightStroke || dataset.strokeColor
	                }));
	            }, this);

	        }, this);

	        this.buildScale(data.labels);
	        // remove the labels - they won't be positioned correctly anyway
	        this.scale.xLabels.forEach(function (e, i, arr) {
	            arr[i] = '';
	        });

	        this.BarClass.prototype.base = this.scale.endPoint;

	        this.eachBars(function (bar, index, datasetIndex) {
	            // change the way the x and width functions are called
	            Chart.helpers.extend(bar, {
	                width: this.scale.calculateBarWidth(index),
	                x: this.scale.calculateBarX(index),
	                y: this.scale.endPoint
	            });

	            bar.save();
	        }, this);

	        this.render();
	    },
	    draw: function (ease) {
	        var easingDecimal = ease || 1;
	        this.clear();

	        var ctx = this.chart.ctx;

	        this.scale.draw(1);

	        Chart.helpers.each(this.datasets, function (dataset, datasetIndex) {
	            Chart.helpers.each(dataset.bars, function (bar, index) {
	                if (bar.hasValue()) {
	                    bar.base = this.scale.endPoint;
	                    // change the way the x and width functions are called
	                    bar.transition({
	                        x: this.scale.calculateBarX(index),
	                        y: this.scale.calculateY(bar.value),
	                        width: this.scale.calculateBarWidth(index)
	                    }, easingDecimal).draw();

	                }
	            }, this);

	        }, this);
	    }
	});
};




function BarRotateLabel() {

	var axisFixedDrawFn = function() {
    var self = this
    var widthPerXLabel = (self.width - self.xScalePaddingLeft - self.xScalePaddingRight) / self.xLabels.length
    var xLabelPerFontSize = self.fontSize / widthPerXLabel
    var xLabelStep = Math.ceil(xLabelPerFontSize)
    var xLabelRotationOld = null
    var xLabelsOld = null

    var widthPerSkipedXLabel = (self.width - self.xScalePaddingLeft - self.xScalePaddingRight) / (self.xLabels.length / xLabelStep)
    xLabelRotationOld = self.xLabelRotation
    xLabelsOld = clone(self.xLabels)
    self.xLabelRotation = 0;

	Chart.Scale.prototype.draw.apply(self, arguments);
	    if (xLabelRotationOld != null) {
	        self.xLabelRotation = xLabelRotationOld
	    }
	    if (xLabelsOld != null) {
	        self.xLabels = xLabelsOld
	    }
	};

	Chart.types.Bar.extend({
	    name : "AxisFixedBar",
	    initialize : function(data) {
	        Chart.types.Bar.prototype.initialize.apply(this, arguments);
	        this.scale.draw = axisFixedDrawFn;
	    }
	});
};
