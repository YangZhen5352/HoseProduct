define("pages/person",function(n){{var e=n("vue"),o=n("alertShow");new e({el:"#person",data:{currentView:"person",phone:"",type:"changephone"},methods:{onhashchange:function(){var n=location.hash.slice(1);switch(n){case"!/changePhone":this.currentView="changePhone";break;default:this.currentView="person"}},go:function(n){window.location.hash="!/"+n}},events:{verifyCode:function(n){$.ajax({url:"/wechat/changephone/",type:"post",data:{phone:this.phone,code:n.code,M_TOKEN:M_TOKEN},dataType:"json",success:function(n){2e6==n.retcode?(location.hash="",location.reload()):o(n.msg,2,"返回","重新修改",function(){location.hash="",location.reload()},function(){location.hash="!/changePhone"})}})}},ready:function(){window.onhashchange=function(){this.onhashchange()}.bind(this),this.onhashchange()},components:{changePhone:n("pages/changephone"),verifyCode:n("points/verify-code")}})}});