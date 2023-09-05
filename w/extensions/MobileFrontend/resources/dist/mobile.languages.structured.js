this.mfModules=this.mfModules||{},this.mfModules["mobile.languages.structured"]=(window.webpackJsonp=window.webpackJsonp||[]).push([[5],{"./src/mobile.languages.structured/LanguageSearcher.js":function(e,t,a){var s=a("./src/mobile.startup/View.js"),n=a("./src/mobile.startup/util.js"),r=a("./src/mobile.languages.structured/util.js");function l(e){var t=r.getStructuredLanguages(e.languages,e.variants,r.getFrequentlyUsedLanguages(),e.showSuggestedLanguages,e.deviceLanguage);s.call(this,n.extend({className:"language-searcher",events:{"click .language-search-banner":e.onBannerClick,"click a":"onLinkClick","input .search":"onSearchInput"},inputPlaceholder:mw.msg("mobile-frontend-languages-structured-overlay-search-input-placeholder"),allLanguagesHeader:mw.msg("mobile-frontend-languages-structured-overlay-all-languages-header").toLocaleUpperCase(),suggestedLanguagesHeader:mw.msg("mobile-frontend-languages-structured-overlay-suggested-languages-header").toLocaleUpperCase(),noResultsFoundHeader:mw.msg("mobile-frontend-languages-structured-overlay-no-results"),noResultsFoundMessage:mw.msg("mobile-frontend-languages-structured-overlay-no-results-body"),allLanguages:t.all,allLanguagesCount:t.all.length,suggestedLanguages:t.suggested,suggestedLanguagesCount:t.suggested.length,showSuggestedLanguagesHeader:t.suggested.length>0},e));var a=e.onOpen;if(a){var l=this;setTimeout((function(){a(l)}),0)}}a("./src/mobile.startup/mfExtend.js")(l,s,{template:n.template('\n<div class="panel">\n\t<div class="panel-body search-box">\n\t\t<input type="search" class="search mw-ui-background-icon-search" placeholder="{{inputPlaceholder}}">\n\t</div>\n</div>\n\n<div class="overlay-content-body">\n\t{{#showSuggestedLanguagesHeader}}\n\t<h3 class="list-header">{{suggestedLanguagesHeader}}</h3>\n\t{{/showSuggestedLanguagesHeader}}\n\t{{#suggestedLanguagesCount}}\n\t<ol class="site-link-list suggested-languages">\n\t\t{{#suggestedLanguages}}\n\t\t\t<li>\n\t\t\t\t<a href="{{url}}" class="{{lang}}" hreflang="{{lang}}" lang="{{lang}}" dir="{{dir}}">\n\t\t\t\t\t<span class="autonym">{{autonym}}</span>\n\t\t\t\t\t{{#title}}\n\t\t\t\t\t\t<span class="title">{{title}}</span>\n\t\t\t\t\t{{/title}}\n\t\t\t\t</a>\n\t\t\t</li>\n\t\t{{/suggestedLanguages}}\n\t</ol>\n\t{{/suggestedLanguagesCount}}\n\t{{#bannerHTML}}\n\t<div class="language-search-banner">\n\t\t{{{.}}}\n\t</div>\n\t{{/bannerHTML}}\n\t{{#allLanguagesCount}}\n\t<h3 class="list-header">{{allLanguagesHeader}} ({{allLanguagesCount}})</h3>\n\t<ul class="site-link-list all-languages">\n\t\t{{#allLanguages}}\n\t\t\t<li>\n\t\t\t\t<a href="{{url}}" class="{{lang}}" hreflang="{{lang}}" lang="{{lang}}" dir="{{dir}}">\n\t\t\t\t\t<span class="autonym">{{autonym}}</span>\n\t\t\t\t\t{{#title}}\n\t\t\t\t\t\t<span class="title">{{title}}</span>\n\t\t\t\t\t{{/title}}\n\t\t\t\t</a>\n\t\t\t</li>\n\t\t{{/allLanguages}}\n\t</ul>\n\t{{/allLanguagesCount}}\n\t<section class="empty-results hidden">\n\t\t<h4 class="empty-results-header">{{noResultsFoundHeader}}</h4>\n\t\t<p class="empty-results-body">{{noResultsFoundMessage}}</p>\n\t</section>\n</div>\n\t'),postRender:function(){this.$siteLinksList=this.$el.find(".site-link-list"),this.$languageItems=this.$siteLinksList.find("a"),this.$subheaders=this.$el.find("h3"),this.$emptyResultsSection=this.$el.find(".empty-results")},addBanner:function(e){this.options.bannerHTML=e,this.options.showSuggestedLanguagesHeader=!0,this.render()},onLinkClick:function(e){var t=this.$el.find(e.currentTarget).attr("lang");mw.hook("mobileFrontend.languageSearcher.linkClick").fire(t),r.saveLanguageUsageCount(t,r.getFrequentlyUsedLanguages())},onSearchInput:function(e){this.filterLanguages(this.$el.find(e.target).val().toLowerCase())},filterLanguages:function(e){var t=[];e?(this.options.languages.forEach((function(a){var s=a.langname;(a.autonym.toLowerCase().indexOf(e)>-1||s&&s.toLowerCase().indexOf(e)>-1||a.lang.toLowerCase().indexOf(e)>-1)&&t.push(a.lang)})),this.options.variants&&this.options.variants.forEach((function(a){(a.autonym.toLowerCase().indexOf(e)>-1||a.lang.toLowerCase().indexOf(e)>-1)&&t.push(a.lang)})),this.$languageItems.addClass("hidden"),t.length?(this.$siteLinksList.find("."+t.join(",.")).removeClass("hidden"),this.$emptyResultsSection.addClass("hidden")):(this.$emptyResultsSection.removeClass("hidden"),mw.hook("mobileFrontend.languageSearcher.noresults").fire(e,this.$emptyResultsSection.get(0))),this.$siteLinksList.addClass("filtered"),this.$subheaders.addClass("hidden")):(this.$languageItems.removeClass("hidden"),this.$siteLinksList.removeClass("filtered"),this.$subheaders.removeClass("hidden"),this.$emptyResultsSection.addClass("hidden"))}}),e.exports=l},"./src/mobile.languages.structured/mobile.languages.structured.js":function(e,t,a){var s=a("./src/mobile.startup/moduleLoaderSingleton.js"),n=a("./src/mobile.languages.structured/LanguageSearcher.js");s.define("mobile.languages.structured/LanguageSearcher",n)},"./src/mobile.languages.structured/rtlLanguages.js":function(e,t){e.exports=["aeb","aeb-arab","ar","arc","arq","arz","azb","bcc","bgn","bqi","ckb","dv","fa","glk","he","khw","kk-arab","kk-cn","ks","ks-arab","ku-arab","lki","lrc","luz","mzn","nqo","pnb","ps","sd","sdh","skr","skr-arab","ug","ug-arab","ur","yi"]},"./src/mobile.languages.structured/util.js":function(e,t,a){var s=mw.log,n=a("./src/mobile.startup/util.js"),r=a("./src/mobile.languages.structured/rtlLanguages.js");e.exports={getDir:function(e){var t=r.indexOf(e.lang)>-1?"rtl":"ltr";return n.extend({},e,{dir:t})},getStructuredLanguages:function(e,t,a,n,r){var l=Object.prototype.hasOwnProperty,u=0,g=0,i=0,o=[],d=[],c=this;function h(e){return e.dir?e:(i++,c.getDir(e))}return(r=function(e,t){var a,s,n=Object.prototype.hasOwnProperty,r={};if(t)return-1!==(s=t.indexOf("-"))&&(a=t.slice(0,s)),e.forEach((function(e){e.lang!==a&&e.lang!==t||(r[e.lang]=!0)})),n.call(r,t)?t:n.call(r,a)?a:void 0}(e,r))&&(Object.keys(a).forEach((function(e){var t=a[e];u=u<t?t:u,g=g>t?t:g})),a[r]=u+1),n?e.map(h).forEach((function(e){l.call(a,e.lang)?(e.frequency=a[e.lang],o.push(e)):d.push(e)})):d=e.map(h),t&&n&&t.map(h).forEach((function(e){l.call(a,e.lang)?e.frequency=a[e.lang]:e.frequency=g-1,o.push(e)})),o=o.sort((function(e,t){return t.frequency-e.frequency})),d=d.sort((function(e,t){return e.autonym.toLocaleLowerCase()<t.autonym.toLocaleLowerCase()?-1:1})),s.warn(0===i?"Direction is provided. Please remove handling in getStructuredLanguages":"`dir` attribute was missing from languages. Is T74153 resolved?"),{suggested:o,all:d}},getFrequentlyUsedLanguages:function(){var e=mw.storage.get("langMap");return e?JSON.parse(e):{}},saveFrequentlyUsedLanguages:function(e){mw.storage.set("langMap",JSON.stringify(e))},saveLanguageUsageCount:function(e,t){var a=t[e]||0;a+=1,t[e]=a>100?100:a,this.saveFrequentlyUsedLanguages(t)}}}},[["./src/mobile.languages.structured/mobile.languages.structured.js",0,1]]]);
//# sourceMappingURL=mobile.languages.structured.js.map.json