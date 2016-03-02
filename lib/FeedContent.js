var FeedContent=function(t){function n(e){if(o[e])return o[e].exports;var r=o[e]={exports:{},id:e,loaded:!1};return t[e].call(r.exports,r,r.exports,n),r.loaded=!0,r.exports}var o={};return n.m=t,n.c=o,n.p="lib/",n(0)}([function(t,n,o){var e,r,i,u=function(t,n){function o(){this.constructor=t}for(var e in n)s.call(n,e)&&(t[e]=n[e]);return o.prototype=n.prototype,t.prototype=new o,t.__super__=n.prototype,t},s={}.hasOwnProperty;e=o(2),i=o(3),google.load("feeds","1"),r=function(t){function n(t,o){this.url=t,this.maxAge=30,n.__super__.constructor.apply(this,arguments),this.hasContent=!1}return u(n,t),n.prototype.handleOptions=function(t){return n.__super__.handleOptions.apply(this,arguments),null!=t&&null!=t.maxAge?this.maxAge=t.maxAge:void 0},n.prototype.initialize=function(t){var n;return n=new google.feeds.Feed(this.url),n.load(function(n){return function(o){var e,r,u,s,a,l,h,c;if(!o.error){for(null!=n.header&&(e=i.header(n.header)),l=9999,n.hasContent=!1,c=o.feed.entries,s=0,a=c.length;a>s;s++)r=c[s],u=new Date(r.publishedDate),h=i.minsAgo(u),l>h&&(l=h),e+=i.listItem(i.tag("span",i.timeAgoAsText(u),{"class":"sideitem"})+i.tag("span",r.title));return e=i.tag("ul",e),t.html(e),n.hasContent=l<n.maxAge,i.log(n+" refreshed. Last entry "+l+" minutes ago")}}}(this))},n.prototype.refresh=function(t){return this.initialize(t)},n}(e),t.exports=r},function(t,n){t.exports=jQuery},function(t,n){var o;o=function(){function t(t,n){this.url=t,this.id,this.lastShown,this.hasContent=!0,this.priority=1,this.contentManager,this.minimumShowTime=1e4,this.handleOptions(n),this.header}return t.prototype.handleOptions=function(t){return null!=t?(null!=t.priority&&(this.priority=t.priority),null!=t.minimumShowTime&&(this.minimumShowTime=t.minimumShowTime),null!=t.header&&(this.header=t.header),null!=t.visibilityFunction?this.isVisible=t.visibilityFunction:void 0):void 0},t.prototype.initialize=function(t){},t.prototype.refresh=function(t){},t.prototype.onPrepareToView=function(t){},t.prototype.onView=function(t){},t.prototype.onHide=function(t){},t.prototype.isVisible=function(t){return!0},t.prototype.toString=function(){return this.constructor.name+" url: "+this.url},t}(),t.exports=o},function(t,n,o){(function(n){var o,e,r,i,u,s,a,l,h,c,f;n.fn.animateHighlight=function(t,o){var e,r;return r=t||"#FFFF9C",e=o||1500,this.each(function(){var t;return t=n(this).css("backgroundColor"),n(this).animate({backgroundColor:r},e/2).animate({backgroundColor:t},e/2)})},Array.prototype.shuffle=function(){return this.sort(function(){return.5-Math.random()})},a=function(t){return"undefined"!=typeof console&&null!==console?console.log(t):void 0},o=function(t){var n,o;return null==t&&(t={}),function(){var e;e=[];for(n in t)o=t[n],e.push(" "+n+'="'+o+'"');return e}().join("")},c=function(t,n,e){return null==n&&(n=""),"<"+t+o(e)+">"+n+"</"+t+">"},s=function(t,n){return null==t&&(t=""),null==n&&(n=""),c("li",t,{"class":n})},i=function(t){return null==t&&(t=""),s(t,"header")},e=function(){return(new Date).valueOf()},h=function(t){return function(t){return Math.floor((e()-t.valueOf())/1e3)}}(this),l=function(t){return function(t){return Math.floor(h(t)/60)}}(this),u=function(t){return function(t){return Math.floor(l(t)/60)}}(this),r=function(t){return function(t){return Math.floor(u(t)/24)}}(this),f=function(t){return r(t)>0?"-"+r(t)+"&nbsp;d":u(t)>0?"-"+u(t)+"&nbsp;h":l(t)>0?"-"+l(t)+"&nbsp;min":h(t)>0?"-"+h(t)+"&nbsp;s":void 0},t.exports={log:a,attributes:o,tag:c,listItem:s,header:i,currentTime:e,secondsAgo:h,minsAgo:l,hoursAgo:u,daysAgo:r,timeAgoAsText:f}}).call(n,o(1))}]);