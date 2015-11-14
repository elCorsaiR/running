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



	$('.slider').slick({
		arrows: false,
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
        if (url != "") {
            window.location.href = url;
        }
	});

    $('.client-row .client-list-checkbox').click(function(e){
        e.stopPropagation();
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






});

function accordion() {
	$('.accordion').on('click', function(){

		if( $(this).hasClass('isSlideDown') ) {
			$(this).next('.accordion-open').removeClass('accordion-opened');
			$(this).removeClass('isSlideDown');
		} else {
			$(this).next('.accordion-open').addClass('accordion-opened');
			$(this).addClass('isSlideDown');
		}
	})
};


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

function AddCharts() {
	/* Charts */


	AddRadarAndPolarCharts();
	AddDonutCharts();
	AddLinearCharts();
	AddBarCharts();
}



function AddLinearCharts() {

	var datal1 = $(".chart1").data("var");
	var chartL1 = $(".chart1").get(0).getContext("2d");
	var myLineChart = new Chart(chartL1).Line(datal1, {
		pointDot : false
	});


	var datal2 = $(".chart3").data("var");
	var chartL2 = $(".chart3").get(0).getContext("2d");
	var myLineChart = new Chart(chartL2).Line(datal2, {
		pointDot : false
	});

	var datal3 = $(".chart5").data("var");
	var chartL3 = $(".chart5").get(0).getContext("2d");
	var myLineChart = new Chart(chartL3).Line(datal3, {
		pointDot : false
	});

	var datal4 = $(".chart7").data("var");
	var chartL4 = $(".chart7").get(0).getContext("2d");
	var myLineChart = new Chart(chartL4).Line(datal4, {
		pointDot : false
	});

	var datal5 = $(".chart9").data("var");
	var chartL5 = $(".chart9").get(0).getContext("2d");
	var myLineChart = new Chart(chartL5).Line(datal5, {
		pointDot : false
	});

	var datal6 = $(".chart11").data("var");
	var chartL6 = $(".chart11").get(0).getContext("2d");
	var myLineChart = new Chart(chartL6).Line(datal6, {
		pointDot : false
	});

	var datal7 = $(".chart13").data("var");
	var chartL7 = $(".chart13").get(0).getContext("2d");
	var myLineChart = new Chart(chartL7).Line(datal7, {
		pointDot : false
	});

	var datal8 = $(".chart15").data("var");
	var chartL8 = $(".chart15").get(0).getContext("2d");
	var myLineChart = new Chart(chartL8).Line(datal8, {
		pointDot : false
	});

};


function AddDonutCharts(){


    var dataD1 = $("#performanceChart").data("var");
	var chartD1 = document.getElementById("performanceChart").getContext("2d");
	var myDoughnutChart = new Chart(chartD1).Doughnut(dataD1,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70,
		tooltipTemplate: "<%= value %>%"
	});

	var dataD2 = $("#chart1").data("var");
	var chartD2 = document.getElementById("chart1").getContext("2d");
	var myDoughnutChart = new Chart(chartD2).Doughnut(dataD2,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70
	});

	var dataD3 = $("#chart2").data("var");
	var chartD3 = document.getElementById("chart2").getContext("2d");
	var myDoughnutChart = new Chart(chartD3).Doughnut(dataD3,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70
	});

	var dataD4 = $("#chart3").data("var");
	var chartD4 = document.getElementById("chart3").getContext("2d");
	var myDoughnutChart = new Chart(chartD4).Doughnut(dataD4,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70
	});

	var dataD5 = $("#chart4").data("var");
	var chartD5 = document.getElementById("chart4").getContext("2d");
	var myDoughnutChart = new Chart(chartD5).Doughnut(dataD5,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70
	});

	var dataD6 = $("#chart5").data("var");
	var chartD6 = document.getElementById("chart5").getContext("2d");
	var myDoughnutChart = new Chart(chartD6).Doughnut(dataD6,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 70
	});


	var dataOptimo = [
	    {
	        value: 1,
	        color:"#ececec",
	        highlight: "#ececec"
	    },
	    {
	        value: 3,
	        color: "#fa874e",
	        highlight: "#fa874e",
	        label: "Angulo Q"
	    }
	]
	var chartOptimo = $(".anatomy1").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataOptimo,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

	var chartOptimo = $(".anatomy4").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataOptimo,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

	var chartOptimo = $(".anatomy7").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataOptimo,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

	var dataBajo = [
	    {
	        value: 1,
	        color:"#ececec",
	        highlight: "#ececec"
	    },
	    {
	        value: 3,
	        color: "#febc46",
	        highlight: "#febc46",
	        label: "Discrepancia"
	    }
	]
	var chartOptimo = $(".anatomy2").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataBajo,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

	var chartOptimo = $(".anatomy5").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataBajo,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

	var chartOptimo = $(".anatomy8").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataBajo,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

	var dataAcept = [
	    {
	        value: 1,
	        color:"#ececec",
	        highlight: "#ececec"
	    },
	    {
	        value: 3,
	        color: "#88768b",
	        highlight: "#88768b",
	        label: "Aceptable"
	    }
	]
	var chartOptimo = $(".anatomy3").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataAcept,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

	var chartOptimo = $(".anatomy6").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataAcept,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

	var chartOptimo = $(".anatomy9").get(0).getContext("2d");
	var myDoughnutChart = new Chart(chartOptimo).Doughnut(dataAcept,{
		segmentShowStroke : false,
		animateRotate : false,
		percentageInnerCutout : 80
	});

};

function AddRadarAndPolarCharts() {

    var dataR1 = $("#performanceRadarChart").data("var");
    var chartR1 = document.getElementById("performanceRadarChart").getContext("2d");
	var myRadarChart = new Chart(chartR1).Radar(dataR1, {
		scaleShowLine : false
	});

	var dataP1 = [
	    {
	        value: 300,
	        color:"#fa874e",
	        highlight: "#fa874e",
	        label: "Angulo Q"
	    },
	    {
	        value: 200,
	        color: "#febc46",
	        highlight: "#febc46",
	        label: "Discrepancia"
	    },
	    {
	        value: 100,
	        color: "#ffcb8c",
	        highlight: "#ffcb8c",
	        label: ""
	    },
	    {
	        value: 300,
	        color: "#cbcad4",
	        highlight: "#cbcad4",
	        label: ""
	    },
	    {
	        value: 200,
	        color: "#88768b",
	        highlight: "#88768b",
	        label: ""
	    }

	];

	var chartP1 = $(".chart-a1").get(0).getContext("2d");

	var chartPolar1 = new Chart(chartP1).PolarArea(dataP1, {
		segmentStrokeWidth : 4
	});

	var chartP2 = $(".chart-a2").get(0).getContext("2d");

	var chartPolar2 = new Chart(chartP2).PolarArea(dataP1, {
		segmentStrokeWidth : 4
	});

	var chartP3 = $(".chart-a3").get(0).getContext("2d");

	var chartPolar3 = new Chart(chartP3).PolarArea(dataP1, {
		segmentStrokeWidth : 4
	});
};


function AddBarCharts() {

	var dataB1 = $("#chart6").data("var");

	// BarChartsWidth();


	var chartB1 = document.getElementById("chart6").getContext("2d");
	var chartBar1 = new Chart(chartB1).Bar(dataB1, {});


	var dataB2 = $(".chart2").data("var");
	var chartB2 = $(".chart2").get(0).getContext("2d");
	var chartBar2 = new Chart(chartB2).Bar(dataB2, {});

	var dataB3 =$(".chart4").data("var");
	var chartB3 = $(".chart4").get(0).getContext("2d");
	var chartBar3 = new Chart(chartB3).Bar(dataB3, {});

	var dataB4 = $(".chart6").data("var");
	var chartB4 = $(".chart6").get(0).getContext("2d");
	var chartBar4 = new Chart(chartB4).Bar(dataB4, {});


	var dataB5 = $(".chart8").data("var");
	var chartB5 = $(".chart8").get(0).getContext("2d");
	var chartBar5 = new Chart(chartB5).Bar(dataB5, {});


	var dataB6 = $(".chart10").data("var");
	var chartB6 = $(".chart10").get(0).getContext("2d");
	var chartBar6 = new Chart(chartB6).Bar(dataB6, {});



	var dataB7 = $(".chart12").data("var");
	var chartB7 = $(".chart12").get(0).getContext("2d");
	var chartBar7 = new Chart(chartB7).Bar(dataB7, {});



	var dataB8 = $(".chart14").data("var");
	var chartB8 = $(".chart14").get(0).getContext("2d");
	var chartBar8 = new Chart(chartB8).Bar(dataB8, {});



	var dataB9 = $(".chart16").data("var");
	var chartB9 = $(".chart16").get(0).getContext("2d");
	var chartBar9 = new Chart(chartB9).Bar(dataB9, {});


};



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
