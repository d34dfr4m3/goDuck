```   
   +-----------------------------------------------------------------------------+
   |  [!] Legal disclaimer: Usage of this shit program for attacking targets     |
   |  without prior mutual consent is illegal.                                   |
   |  It is the end user's responsibility to obey all applicable local, state and|
   |  federal laws.                                                              |
   |  Developers assume no liability and are not responsible for any misuse or   |
   |  damage caused by this program                                              |
   +-----------------------------------------------------------------------------+
```
# goDuck 
O nome é goDuck porquê o google me ferrou por mais de 4 dias na corrida e ai eu apelei pro DuckDuckGo, O DDG é foda!

- Sim, isso é um esboço, ta tudo mal feito


#### How To
- fazer o arquivo com dependencias p/ instalação.
- Getopt
- Implementar função de ler um arquivo com dorks e executar.
- Salvar os resultados em um arquivo.
- Optmizar a query. 
- Analisar se existe uma forma de deixar a query mais acertiva. 
- Banner, eu gosto de banners. 
- Opção de usar com a Tor, já que o DuckDuckGo não bloqueia de imediato, só depois de algumas querys, o problema é que vai ser necessário ficar reiniciando o circuito a cada block.
- Refatorar é utopia

##### Requisitos
- https://github.com/joequery/requests-sslv3.git(?)
- html5lib
- proxybroken
- urllib3
- requests
- BeautifulSoup

## DuckDuckGo
- https://duck.co/help/results/syntax 

###### Safe Search
Safe search:

    Add !safeon or !safeoff to the end of your search to turn on and off safe search for that search.

Limitations:

###### URL: 
Adicionado o seguinte código na URL você desabilita o safe search.
```
t=lm  --> None
```

#### Research DDG 
```
 https://duckduckgo.com/?q=[PAYLOAD]&t=lm&ia=web
 https://duckduckgo.com/?q=inurl:bbs/view.php?no=&t=lm&ia=web
```

product.php?shopprodid=

Working Examples:
```
Dork: inurl:bbs/view.php?no=
inurl:"bbs/view.php?no=" -> FAIL
inurl:'bbs/view.php?no=' -> FAIL
inurl:*bbs/view.php?no= -> Almost fail
inurl:*.bbs inurl:view filetype:php inurl:'no=' Get better results
inurl:*.bbs/view filetype:php inurl:'no=' -> FAIL 
inurl:*.bbs/view.php?no= -> Dont work very well FAIL  -> FAIL
inurl:*.bbs/view filetype:php inurl:no= -> FAIL 

".php?no=" inurl:bbs/view 

inurl:bbs/view.php ?no=
inurl:((bbs/view.php?no=)

Primeiro faz o search e depois aplica o filtro, prettycool huh
MATCH -> inurl:bbs/view.php?no= (bbs/view.php?no=)


inurl:advSearch_h.php?idCategory= (advSearch_h.php?idCategory=)

```
##### Search Examples:
```
Example          	Result
cats dogs 		Results about cats or dogs
"cats and dogs" 	Results for exact term "cats and dogs"
cats -dogs 		Fewer dogs in results
cats +dogs 		More dogs in results
cats filetype:pdf 	PDFs about cats. Supported file types: pdf, doc(x), xls(x), ppt(x), html
dogs site:example.com 	Pages about dogs from example.com
cats -site:example.com  Pages about cats, excluding example.com
intitle:dogs 		Page title includes the word "dogs"
inurl:cats 		Page url includes the word "cats"
```

###### logical Operators and another shit I read in papers 
OR 
" " -> Exaclty search, but that's not true

intitle can be used just with t:

Word In the Text: 
inbody: or b:

FileType:
fracking licences filetype:pdf

Time research: "Any Time" option only goes up to the past month


definitions -> finds definitions of words or phrases ofor example: define dialectic

Limit by Geography: region or r: Followed by two letter country code

Boolean: AND, OR  and parentheses (). 
 and use space ' ' -> A and B =:> a b 




###### DuckDuckGo ! BANGS -> !google -> FAIL 
Request URL:

Intercept Request using Browser:
```
GET /search?hl=en&q=inurl%3Abbs%2Fview.php%3Fno%3D HTTP/1.1
Host: google.com
User-Agent: Mozilla/5.0 
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Language: en-US,en;q=0.5
Accept-Encoding: gzip, deflate
DNT: 1
Connection: close
Cookie: CGIC=Ij90ZXh0L2h0bWwsYXBwbGljYXRpb24veGh0bWwreG1sLGFwcGxpY2F0aW9uL3htbDtxPTAuOSwqLyo7cT0wLjg; 1P_JAR=2019-01-06-21; NID=154=Plo8Xb1yK08EW5vTZtAlgQj--J2EhfTkW7yqtfaEhKpnCh0g7-Jd9wyDYdxcy_OVsSKPJWUV0omtMXYy6dNS_UtaIZbMc8d6bKKEpkbPwYorM-6MWBflXfaI7D7dDXnPckuMlOiwiT_AoPdD1pVd3T97Z0Rebm8S39c_abHvHlM
Upgrade-Insecure-Requests: 1
```
The bastard just redirect me with the next response:

```
<html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><meta name='referrer' content='never'><meta name='robots' content='noindex, nofollow'><meta http-equiv='refresh' content='0; url=https://google.com/search?hl=en&q=inurl%3Aadd.php%3Fbookid%3D'></head><body><script language='JavaScript'>function ffredirect(){window.location.replace('https://google.com/search?hl=en&q=inurl%3Aadd.php%3Fbookid%3D');}setTimeout('ffredirect()',100);</script></body></html>
```

#### Scrapping
Query response quando o DDG detecta que vocẽ não tem JS ele tenta te redirecionar para uma página non-js:

```
<!DOCTYPE html>
<!--[if IEMobile 7 ]> <html lang="en_US" class="no-js iem7"> <![endif]-->
<!--[if lt IE 7]> <html lang="en_US" class="no-js ie6 lt-ie10 lt-ie9 lt-ie8 lt-ie7"><![endif]-->
<!--[if IE 7]>    <html lang="en_US" class="no-js ie7 lt-ie10 lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>    <html lang="en_US" class="no-js ie8 lt-ie10 lt-ie9  has-zcm"><![endif]-->
<!--[if IE 9]>    <html lang="en_US" class="no-js ie9 lt-ie10 has-zcm"> <![endif]-->
<!--[if (gte IE 9)|(gt IEMobile 7)|!(IEMobile)|!(IE)]><!-->
<html class="no-js has-zcm ">
 <!--<![endif]-->
 <head>
  <meta content="IE=edge, chrome=1" http-equiv="X-UA-Compatible"/>
  <meta content="text/html; charset=utf-8" http-equiv="content-type"/>
  <title>
   inurl:modules/forum/index.php?topic_id= (modules/forum/index.php?topic_id=) at DuckDuckGo
  </title>
  <link href="/s1718.css" rel="stylesheet" type="text/css"/>
  <link href="/r1718.css" rel="stylesheet" type="text/css"/>
  <link href="manifest.json" rel="manifest"/>
  <meta content="noindex,nofollow" name="robots"/>
  <meta content="origin" name="referrer"/>
  <link href="/favicon.ico" rel="shortcut icon" sizes="16x16 24x24 32x32 64x64" type="image/x-icon">
   <link href="/assets/icons/meta/DDG-iOS-icon_60x60.png" rel="apple-touch-icon">
    <link href="/assets/icons/meta/DDG-iOS-icon_76x76.png" rel="apple-touch-icon" sizes="76x76">
     <link href="/assets/icons/meta/DDG-iOS-icon_120x120.png" rel="apple-touch-icon" sizes="120x120"/>
     <link href="/assets/icons/meta/DDG-iOS-icon_152x152.png" rel="apple-touch-icon" sizes="152x152"/>
     <link href="/assets/icons/meta/DDG-icon_256x256.png" rel="image_src"/>
     <script type="text/javascript">
      var ct,fd,fq,it,iqa,iqm,iqs,iqp,iqq,qw,dl,ra,rv,rad,r1hc,r1c,r2c,r3c,rfq,rq,rds,rs,rt,rl,y,y1,ti,tig,iqd,locale,settings_js_version='s2470',is_twitter='',rpl=0;fq=0;fd=1;it=0;iqa=0;iqbi=0;iqm=0;iqs=0;iqp=0;iqq=0;qw=2;dl='';ct='BR';iqd=0;r1hc=0;r1c=0;r3c=0;rq='inurl%3Amodules%2Fforum%2Findex.php%3Ftopic_id%3D%20(modules%2Fforum%2Findex.php%3Ftopic_id%3D)';rqd="inurl:modules/forum/index.php?topic_id= (modules/forum/index.php?topic_id=)";rfq=0;rt='';ra='lm';rv='';rad='';rds=30;rs=0;spice_version='1387';spice_paths='{}';locale='en_US';settings_url_params={};rl='wt-wt';rlo=0;df='';ds='';sfq='';iar='';vqd='3-92388203301068987530893731738730400851-147278774700298001653928627302287641514';safe_ddg=0;;
     </script>
     <meta content="width=device-width, initial-scale=1" name="viewport">
      <meta content="true" name="HandheldFriendly">
       <meta content="no" name="apple-mobile-web-app-capable"/>
      </meta>
     </meta>
    </link>
   </link>
  </link>
 </head>
 <body class="body--serp">
  <input id="state_hidden" name="state_hidden" size="1" type="text"/>
  <span class="hide">
   Ignore this box please.
  </span>
  <div id="spacing_hidden_wrapper">
   <div id="spacing_hidden">
   </div>
  </div>
  <script src="/locales/en_US/LC_MESSAGES/duckduckgo-duckduckgo+sprintf+gettext+locale-simple.20190103.053003.js" type="text/javascript">
  </script>
  <script src="/lib/l110.js" type="text/javascript">
  </script>
  <script src="/util/u293.js" type="text/javascript">
  </script>
  <script src="/d2543.js" type="text/javascript">
  </script>
  <div class="site-wrapper js-site-wrapper">
   <div class="header-wrap js-header-wrap" id="header_wrapper">
    <div class="header cw" id="header">
     <div class="header__search-wrap">
      <a class="header__logo-wrap js-header-logo" href="/?t=lm" tabindex="-1">
       <span class="header__logo js-logo-ddg">
        DuckDuckGo
       </span>
      </a>
      <div class="header__content header__search">
       <form action="/" class="search--adv search--header js-search-form" id="search_form" name="x">
        <input autocomplete="off" class="search__input--adv js-search-input" id="search_form_input" name="q" tabindex="1" type="text" value="inurl:modules/forum/index.php?topic_id= (modules/forum/index.php?topic_id=)"/>
        <input class="search__clear js-search-clear" id="search_form_input_clear" tabindex="3" type="button" value="X">
         <input class="search__button js-search-button" id="search_button" tabindex="2" type="submit" value="S">
          <a class="search__dropdown" href="javascript:;" id="search_dropdown" tabindex="4">
          </a>
          <div class="search__hidden js-search-hidden" id="search_elements_hidden">
          </div>
         </input>
        </input>
       </form>
      </div>
     </div>
     <div class="zcm-wrap zcm-wrap--header is-noscript-hidden" id="duckbar">
     </div>
    </div>
    <div class="header--aside js-header-aside">
    </div>
   </div>
   <div class="zci-wrap" id="zero_click_wrapper">
   </div>
   <div class="verticals" id="vertical_wrapper">
   </div>
   <div class="content-wrap " id="web_content_wrapper">
    <div class="serp__top-right js-serp-top-right">
    </div>
    <div class="serp__bottom-right js-serp-bottom-right">
     <div class="js-feedback-btn-wrap">
     </div>
    </div>
    <div class="cw">
     <div class="serp__results js-serp-results" id="links_wrapper">
      <div class="results--main">
       <div class="search-filters-wrap">
        <div class="js-search-filters search-filters">
        </div>
       </div>
       <noscript>
        <meta content="0;URL=/html?q=inurl%3Amodules%2Fforum%2Findex.php%3Ftopic_id%3D%20(modules%2Fforum%2Findex.php%3Ftopic_id%3D)" http-equiv="refresh"/>
        <link href="/css/noscript.css" rel="stylesheet" type="text/css"/>
        <div class="msg msg--noscript">
         <p class="msg-title--noscript">
          You are being redirected to the non-JavaScript site.
         </p>
         Click
         <a href="/html/?q=inurl%3Amodules%2Fforum%2Findex.php%3Ftopic_id%3D%20(modules%2Fforum%2Findex.php%3Ftopic_id%3D)">
          here
         </a>
         if it doesn't happen automatically.
        </div>
       </noscript>
       <div class="results--message" id="message">
       </div>
       <div class="ia-modules js-ia-modules">
       </div>
       <div class="results--ads results--ads--main is-hidden js-results-ads" id="ads">
       </div>
       <div class="results is-hidden js-results" id="links">
       </div>
      </div>
      <div class="results--sidebar js-results-sidebar">
       <div class="sidebar-modules js-sidebar-modules">
       </div>
       <div class="is-hidden js-sidebar-ads">
       </div>
      </div>
     </div>
    </div>
   </div>
   <div id="bottom_spacing2">
   </div>
  </div>
  <script type="text/javascript">
  </script>
  <script type="text/JavaScript">
   function nrji() {nrj('/t.js?q=inurl%3Amodules%2Fforum%2Findex.php%3Ftopic_id%3D%20(modules%2Fforum%2Findex.php%3Ftopic_id%3D)&l=wt-wt&s=0&ct=BR&ss_mkt=us&p_ent=&ex=-1');nrj('/d.js?q=inurl%3Amodules%2Fforum%2Findex.php%3Ftopic_id%3D%20(modules%2Fforum%2Findex.php%3Ftopic_id%3D)&l=wt-wt&s=0&a=lm&ct=BR&ss_mkt=us&vqd=3-92388203301068987530893731738730400851-147278774700298001653928627302287641514&p_ent=&ex=-1&sp=1');;};DDG.ready(nrji, 1);
  </script>
  <script src="/g2050.js">
  </script>
  <script type="text/javascript">
   DDG.page = new DDG.Pages.SERP({ showSafeSearch: 0, instantAnswerAds: false });
  </script>
  <div id="z2">
  </div>
  <div id="z">
  </div>
 </body>
</html>

```

Na documentação diz que eles tem duas versões não JS: 

- https://duckduckgo.com/html
- https://duckduckgo.com/lite

Só trocar a URL 

result__url
###### Read The Docs
- http://pygoogle.sourceforge.net/dist/doc/index.html
- https://github.com/joequery/requests-sslv3.git
- ttps://en.wikipedia.org/wiki/X-Forwarded-For
- http://www.rba.co.uk/search/compare.pdf
- https://www.whoishostingthis.com/resources/boolean-search/

- https://duckduckgo.com/params
- https://duck.co/help/results/syntax
- https://news.ycombinator.com/item?id=15291961
- http://arnoreuser.com/downloads/quickreferencesheets/DuckDuckGo_FULL.pdf
###### Search Engines to try if get fuckedup
- www.startpage.com Don't work with dorks very well
- https://www.lukol.com Work with dorks because use custom search engine(cse), some kind of api (?) but requires JS, so we get fuckedu_p                        
- https://www.gibiru.com Don't Work with dorks                                
- Google blocks, i try a trick using proxies but google has a lot of money to pay engineers to fuck my ass 

