FoxUI.actionsheet = {
	show: function(buttons, round, close) {

		round = round || false;
		close = close || true;

		buttons = buttons || [];

		buttons.push({
			'text': FoxUI.defaults.cancelText,
			extraClass: 'cancel'
		});

		var buttonsHTML = '';
		$.each(buttons, function(i, btn) {
			buttonsHTML += '<a href="javascript:;" class="' + (btn.extraClass ? btn.extraClass : '') + '">' + btn.text + '</a>';
		});
		var actionSheetHTML = "<div class='fui-actionsheet " + (round ? 'fui-actionsheet-o' : '') + "'>" + buttonsHTML + "</div>";

		var modal = FoxUI.modal.show(actionSheetHTML, true);
		setTimeout(function() {
			$('.fui-actionsheet').addClass('in');
		}, 0);

		$('.fui-mask').click(function() {
			FoxUI.actionsheet.hide();
		});

		$('.fui-actionsheet a', modal).each(function(index, el) {
			$(el).click(function(e) {

				if (close) {
					FoxUI.actionsheet.hide();
				}

				if (buttons[index].onclick) {
					buttons[index].onclick(modal, e);
				}
			});
		});
	},
	hide: function() {

		$('.fui-actionsheet').addClass('out').transitionEnd(function(e) {
			$('.fui-actionsheet').remove();
		});
		FoxUI.mask.hide();
	}
}
FoxUI.according = {

	init: function() {

		$('.fui-according').each(function() {
			var self = $(this);
			var header = self.find('.fui-according-header');
			var group = self.closest('.fui-according-group');
			header.click(function() {
				group.find('.fui-according').not(self).each(function() {
					FoxUI.according.collapse($(this).closest('.fui-according'));
				});
				if (self.hasClass('fui-according-expanded')) {
					FoxUI.according.collapse(self);
				} else {
					FoxUI.according.expand(self);
				}

			});
		})
	},
	expand: function(according) {
		var content = according.find('.fui-according-content');
		content.css('height', content[0].scrollHeight + 'px');
		according.addClass('fui-according-expanded');
	},
	collapse: function(according) {
		according.find('.fui-according-content').css('height', '');
		according.removeClass('fui-according-expanded');
	}

}

var FoxUISwipe = function(swipe, params) {
	var defaults = {
		transition: 300,
		speed: 3000,
		gap: 0,
		touch: true,
		placeholder: "data:image/gif;base64,R0lGODlhAQABAIAAAOXl5QAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw=="
	};
	var self = this;
	swipe = $(swipe);
	self.params = $.extend({}, defaults, params || {});
	self.wrapper = swipe.find('.fui-swipe-wrapper');
	self.items = self.wrapper.find('.fui-swipe-item');
	self.container[0].page = swipe.find('.fui-swipe-page');
	self.bullets = self.container[0].page.find('.fui-swipe-bullet');
	self.buttons = swipe.find('.fui-swipe-button');
	self.params.speed = swipe.data('speed') || self.params.speed;
	self.params.gap = swipe.data('gap') || self.params.gap;
	self.params.touch = swipe.data('touch') || self.params.touch;
	if (self.items.length < 2) {
		return;
	}
	var allowItemClick = true;


	self.interval = 0;
	self.width = swipe.width(); //anjey

	self.setBullet = function() {

		var bullet = $(self.bullets[self.activeIndex]);
		if (bullet.length > 0) {
			self.container[0].page.find('.active').removeClass('active');
			bullet.addClass('active');
		}

	}
	self.slide = function(activeIndex, transition) {


		self.activeIndex = activeIndex;
		self.setBullet();
		if (self.params.onStart) {
			self.params.onStart(self);
		}
		transition = transition || self.params.transition;
		var num = -(activeIndex * self.width);

		if (self.params.gap) {

			num -= self.params.gap * (activeIndex - 1) + self.params.gap;

		}
		var transform = 'translate3d(' + num + 'px,0,0)';

		self.wrapper.transition(transition).transform(transform).transitionEnd(function(e) {

			if (self.params.speed) {
				self.begin();
			}
			allowItemClick = true;
			if (self.params.onChange) {
				self.params.onChange(self);
			}
		});

	}
	self.prev = function() {

		clearTimeout(self.interval);

		self.activeIndex--;
		if (self.activeIndex < 0) {
			self.activeIndex = 0;
		}
		self.slide(self.activeIndex);

	}
	self.next = function(delay) {


		clearTimeout(this.interval);
		self.activeIndex++;
		if (self.activeIndex > self.items.length - 1) {
			self.activeIndex = 0;
		}
		self.slide(self.activeIndex);

	}

	self.begin = function() {
		if (self.params.speed) {

			self.interval = setTimeout(function() {
				self.next();
			}, self.params.speed);
		}
	}
	var isTouched, isMoved;
	var onTouchStart = function(e) {
		if (isTouched) {
			return;
		}

		e.preventDefault();
		self.start = {
			pageX: e.type === 'touchstart' ? e.originalEvent.targetTouches[0].pageX : e.pageX,
			pageY: e.type === 'touchstart' ? e.originalEvent.targetTouches[0].pageY : e.pageY,
			time: Number(new Date())
		};

		self.isScrolling = undefined;
		self.deltaX = 0;
		self.wrapper.transition(0);

		isTouched = true;
		allowItemClick = true;


	}
	var onTouchMove = function(e) {
		if (!isTouched) {
			return;
		}

		allowItemClick = false;
		e.preventDefault();

		var pageX = e.type === 'touchmove' ? e.originalEvent.targetTouches[0].pageX : e.pageX;
		var pageY = e.type === 'touchmove' ? e.originalEvent.targetTouches[0].pageY : e.pageY;
		self.deltaX = pageX - self.start.pageX;

		if (self.isScrolling === undefined) {
			self.isScrolling = !!(self.isScrolling || Math.abs(self.deltaX) < Math.abs(pageY - self.start.pageY));
		}

		if (!self.isScrolling) {

			e.preventDefault();
			allowItemClick = false;
			clearTimeout(self.interval);
			self.deltaX =
				self.deltaX /
				((!self.activeIndex && self.deltaX > 0 || self.activeIndex == self.items.length - 1 && self.deltaX < 0) ?
					(Math.abs(self.deltaX) / self.width + 1) // determine resistance level
					: 1);

			var transform = 'translate3d(' + (self.deltaX - self.activeIndex * self.width) + 'px,0,0)';
			self.wrapper.transform(transform);
		}
	}
	var onTouchEnd = function(e) {


		if (!isTouched) {

			isTouched = false;
			return;
		}

		isTouched = false;

		var isValidSlide =
			Number(new Date()) - self.start.time < 250 && Math.abs(self.deltaX) > 20 || Math.abs(self.deltaX) > self.width / 2,


			isPastBounds = !self.activeIndex && self.deltaX > 0 || self.activeIndex == self.items.length - 1 && self.deltaX < 0;

		if (!self.isScrolling) {
			self.slide(self.activeIndex + (isValidSlide && !isPastBounds ? (self.deltaX < 0 ? 1 : -1) : 0));
		}

	}

	var onItemClick = function(e) {

		if (!allowItemClick) {
			return;
		}

		var url = $(this).data('url') || '';

		if (url) {
			location.href = url;
		}
	}

	if (self.params.gap) {

		$.each(self.items, function() {
			$(this).css('margin-right', self.params.gap + 'px');
		})
	}
	var resizeSwipes = function() {
		self.width = $(document.body).width();
		$.each(self.items, function() {
			$(this).css('width', self.width + 'px');
		});
		self.slide(self.activeIndex, 0);
	}
	$(window).on('resize', resizeSwipes);

	self.init = function() {
		//分页
		if (self.container[0].page.length > 0) {
			if (self.bullets.length <= 0) {
				var bulletsHTML = '';
				for (var i = 0; i < self.items.length; i++) {
					bulletsHTML += '<div class="fui-swipe-bullet"></div>';
				}
				self.container[0].page.html(bulletsHTML);
				self.bullets = self.container[0].page.find('.fui-swipe-bullet');
			}

			self.bullets.each(function(index) {

				$(this).click(function() {
					clearTimeout(self.interval);
					self.activeIndex = index;
					self.slide(self.activeIndex);
				});

			});
		}
		//按钮
		self.buttons.each(function(i) {
			$(this).click(function() {

				if ($(this).hasClass('left')) {
					self.prev();
				} else {
					self.next();
				}

			})
		});
	}

	self.init();

	self.slide(0, 0);
	self.begin();

	self.initEvents = function(detach) {
		var method = detach ? 'off' : 'on';
		self.wrapper[method]($.touchEvents.start, onTouchStart);
		self.wrapper[method]($.touchEvents.move, onTouchMove);
		self.wrapper[method]($.touchEvents.end, onTouchEnd);
		self.items[method]('click', onItemClick);
	}
	if (self.params.touch) {
		self.initEvents();
	}

}

$(function() {

	$.fn.swipe = function(params) {
		var args = arguments;
		return this.each(function() {

			if (!this) return;
			var $this = $(this);
			var swipe = $this.data("swipe");
			if (!swipe) {
				params = params || {};
				swipe = new FoxUISwipe(this, params);
				$this.data("swipe", swipe);
			}
			if (typeof params === typeof "a") {
				swipe[params].apply(picker, Array.prototype.slice.call(args, 1));
			}
		});
	};
});


var FoxUILasyLoad = function(params) {
	var defaults = {

		offset: 0,
		throttle: 250,
		placeholder: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC"

	}
	self.params = $.extend({}, defaults, params || {});

	var offset = self.params.offset || 0;
	self.params.offsetVertical = self.params.offsetVertical || offset;
	self.params.offsetHorizontal = self.params.offsetHorizontal || offset;

	self.toInt = function(str, defaultValue) {

		return parseInt(str || defaultValue, 10);
	};

	var offset = {
		top: self.toInt(self.params.offsetTop, self.params.offsetVertical),
		bottom: self.toInt(self.params.offsetBottom, self.params.offsetVertical),
		left: self.toInt(self.params.offsetLeft, self.params.offsetHorizontal),
		right: self.toInt(self.params.offsetRight, self.params.offsetHorizontal)
	};


	self.container = self.params.container || $(document);
	self.images = document.querySelectorAll('img[data-lazy], [data-lazy-background]');



	self.inView = function(element, view) {

		if (element.offsetParent === null) {
			return false;
		}
		var rect = element.getBoundingClientRect();

		return (
			rect.right >= self.view.left &&
			rect.bottom >= self.view.top &&
			rect.left <= self.view.right &&
			rect.top <= self.view.bottom
		);
	}


	self.initEvents = function() {

		self.container.scroll(onScroll);
		clearTimeout(self.interval);
	};

	self.interval = null;
	var onScroll = function(e) {

		clearTimeout(self.interval);
		self.interval = setTimeout(function() {
			self.render();
			self.interval = null;
		}, self.params.throttle);

	}
	var unload = !!self.params.unload;
	self.render = function() {

		$.each(self.images, function(i) {
			var $this = $(this);
			var inview = self.inView(this);

			if (inview) {
				if ($this.data('lazy-background')) {
					$this.css({
						'background-image': "url(" + $this.data('lazy-background')
					});
				} else {
					if ($this.data('lazy')) {
						this.src = $this.data('lazy');
						this.onload = function() {
							this.style.height = 'auto';
						};
					}
				}
				$this.removeData('lazy-background');
				$this.removeData('lazy');
				$this.data('loaded', true);


			} else {

				var placeholder = $this.data('lazy-placeholder') || self.params.placeholder;

				if (placeholder && !$this.data('loaded')) {
					if ($this.data('lazy-background')) {
						this.style.backgroundImage = "url(" + placeholder + ")";
					} else {

						this.src = placeholder;
					}
				}

				$this.removeData('lazy-placeholder');

			}
			if (self.params.onLoad) {
				self.params.onLoad(self, this);
			}

		});
		if (self.images.length <= 0) {
			self.initEvents(true);
		}
	}


	self.view = {
		left: 0 - offset.left,
		top: 0 - offset.top,
		bottom: (window.innerHeight || document.documentElement.clientHeight) + offset.bottom,
		right: (window.innerWidth || document.documentElement.clientWidth) + offset.right
	};

	$('<img />').attr('src', self.params.placeholder).load(function() {

		var ratio = this.height / this.width;
		$.each(self.images, function(i) {
			if (!$(this).height()) {

				var outerWidth = $(this).parent().length > 0 ? $(this).parent().outerWidth() : '';
				outerWidth = outerWidth || self.container.outerWidth();
				var height = outerWidth * ratio;

				this.style.height = height + 'px';
			}
		})
		self.render();
		if (self.images.length > 0) {
			self.initEvents();
		}

	});
}

FoxUI.lazyload = function(params) {
	new FoxUILasyLoad(params);
}

FoxUI.pagepull = function(params) {
    
	self.loading = false;
	
	$(window).scroll(function(e) {

		if (self.loading) {
			return;
		}
		console.log();
		var totalheight = parseFloat($(window).height()) + parseFloat($(window).scrollTop());
		if ($(document).height() <= totalheight) {
			self.loading = true;
			$(document.body).find('.fui-pullup-loading').show();
			if (params.onPullUp) {
				params.onPullUp(self);
			}
		}
		
		if( $(window).scrollTop() <=0){
			if (params.onPullDown) {
				params.onPullDown(self);
			}
		}
	});
}
 