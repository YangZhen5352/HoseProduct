define("pages/product",function(e){function t(){for(v in r)r.hasOwnProperty(v)&&(r[v].className="item");r[s].classList.add("active"),i=!1,console.log("transitionend")}var n=(e("wechat"),e("Zepto")),s=0,i=!1,a=n(".tap-wrap li"),r=document.querySelectorAll(".tap-items .item");n(".tap-wrap").swipeLeft(function(){if(!i&&s+1!==r.length){i=!0;var e=s,d=s+1;r[e].removeEventListener("transitionend",t,!1),r[d].removeEventListener("transitionend",t,!1),n(a[e]).css("background","green"),n(a[d]).css("background","red"),r[d].classList.add("next"),r[e].addEventListener("transitionend",t,!1),r[d].addEventListener("transitionend",t,!1),r[e].classList.add("left"),setTimeout(function(){r[d].classList.add("left")},0),2>s?s++:s=2}}),n(".tap-wrap").swipeRight(function(){n(a[s]).css("background","green"),s>0?s--:s=0,n(a[s]).css("background","red"),n(r[s]).css("left",0)})});