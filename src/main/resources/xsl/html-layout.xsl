<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xalan="http://xml.apache.org/xalan"
  xmlns:i18n="xalan://org.mycore.services.i18n.MCRTranslation"
  xmlns:encoder="xalan://java.net.URLEncoder" 
  exclude-result-prefixes="xsl xalan i18n encoder">

  <xsl:output method="html" encoding="UTF-8" media-type="text/html" indent="yes" xalan:indent-amount="2" />

  <xsl:param name="CurrentLang" />

  <xsl:variable name="jquery.version" select="'3.3.1'" />
  <xsl:variable name="jquery-ui.version" select="'1.12.1'" />
  <xsl:variable name="chosen.version" select="'1.8.7'" />
  <xsl:variable name="bootstrap.version" select="'4.1.3'" />
  <xsl:variable name="font-awesome.version" select="'5.5.0'" />

  <!-- ==================== IMPORTS ==================== -->
  <!-- additional stylesheets -->
  <xsl:include href="coreFunctions.xsl" />
  <xsl:include href="html-layout-backend.xsl" />


  <!-- ==================== HTML ==================== -->
  
  <xsl:template match="/html">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html>

    </xsl:text>
    <html lang="{$CurrentLang}">
      <xsl:apply-templates select="head" />
      <xsl:call-template name="layout" />
    </html>
  </xsl:template>

  <xsl:template match="head">
    <head>
      <meta charset="utf-8" />

      <meta name="viewport" content="width=device-width, initial-scale=1" />
      <meta http-equiv="x-ua-compatible" content="ie=edge" />

      <link href="{$WebApplicationBaseURL}rsc/sass/scss/bootstrap-ubo.css" rel="stylesheet" />
      <link href="{$WebApplicationBaseURL}rsc/sass/scss/bootstrap-softec.css" rel="stylesheet" />
      <script type="text/javascript" src="{$WebApplicationBaseURL}webjars/jquery/{$jquery.version}/jquery.min.js"></script>
      <script type="text/javascript" src="{$WebApplicationBaseURL}webjars/bootstrap/{$bootstrap.version}/js/bootstrap.bundle.min.js"></script>
      <script type="text/javascript" src="{$WebApplicationBaseURL}webjars/chosen-js/{$chosen.version}/chosen.jquery.min.js"></script>
      <link href="{$WebApplicationBaseURL}webjars/chosen-js/{$chosen.version}/chosen.min.css" rel="stylesheet" />
      <script type="text/javascript" src="{$WebApplicationBaseURL}webjars/jquery-ui/{$jquery-ui.version}/jquery-ui.js"></script>
      <link rel="stylesheet" href="{$WebApplicationBaseURL}webjars/jquery-ui/{$jquery-ui.version}/jquery-ui.css" type="text/css"/>
      <link rel="stylesheet" href="{$WebApplicationBaseURL}webjars/font-awesome/{$font-awesome.version}/css/all.css" type="text/css"/>
      <link rel="stylesheet" href="{$WebApplicationBaseURL}webjars/bootstrap-glyphicons/bdd2cbfba0/css/bootstrap-glyphicons.css" type="text/css"/>
      <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Droid+Sans|Droid+Sans+Mono" type="text/css" />
      <link rel="apple-touch-icon-precomposed" sizes="114x114" href="https://www.uni-due.de/imperia/md/images/cms/h/apple-touch-icon.png" />
      <link rel="apple-touch-icon-precomposed" sizes="72x72" href="https://www.uni-due.de/imperia/md/images/cms/m/apple-touch-icon.png" />
      <link rel="apple-touch-icon-precomposed" href="https://www.uni-due.de/imperia/md/images/cms/l/apple-touch-icon-precomposed.png" />
      <link rel="shortcut icon" href="https://www.uni-due.de/imperia/md/images/cms/l/apple-touch-icon.png" />
      <link rel="shortcut icon" href="{$WebApplicationBaseURL}images/favicon.ico" />

      <script type="text/javascript">var webApplicationBaseURL = '<xsl:value-of select="$WebApplicationBaseURL" />';</script>
      <script type="text/javascript">var currentLang = '<xsl:value-of select="$CurrentLang" />';</script>

      <xsl:copy-of select="node()" />
    </head>
  </xsl:template>

  <!-- all layout -->
  <xsl:template name="layout">
    <body class="d-flex flex-column">
      <xsl:call-template name="layout.headerline" />
      <xsl:call-template name="layout.header" />
      <xsl:call-template name="layout.navigation" />
      <xsl:call-template name="layout.topcontainer" />
      <xsl:call-template name="layout.body" />
      <xsl:call-template name="layout.footer" />
    </body>
  </xsl:template>

  <xsl:template name="layout.topcontainer">
    <div id="topcontainer">
      <div class="container">
        <div class="row">
          <div class="col">
            <xsl:call-template name="layout.pageTitle"/>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-9">
            <xsl:call-template name="layout.breadcrumbPath"/>
          </div>
          <div class="col-lg-3 pl-0">
            <xsl:call-template name="layout.basket.info"/>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- html body -->
  <xsl:template name="layout.body">
    <div class="bodywrapper pt-3">
      <div class="container d-flex flex-column flex-grow-1">
        <div class="row">
          <div class="col-lg">
            <xsl:call-template name="layout.inhalt" />
          </div>
          <xsl:if test="body/aside[@id='sidebar']">
            <div class="col-lg-3 pl-lg-0">
              <xsl:copy-of select="body/aside[@id='sidebar']" />
            </div>
          </xsl:if>
        </div>
        <div class="row">
          <div class="col">
            <hr class="mb-0"/>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="layout.navigation">
    <div id="navigationMainContainer">
      <div class="container">
        <nav class="navbar navbar-expand-lg p-0" role="navigation" id="hauptnavigation">
          <button class="navbar-toggler ml-auto" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav" id="mainnav">
              <!-- Find the item that is the root of the navigation tree to display -->
              <xsl:for-each select="$navigation.tree">
                <xsl:apply-templates select="item[@label|label]" mode="navigation" />
              </xsl:for-each>
            </ul>
          </div>
        </nav>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="layout.headerline">
    <div id="headerLine" class="d-flex align-items-center bg-white">
      <div class="container" >
        <div class="row">
          <nav class="col">
            <ul class="nav">
              <li class="">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button">
                  <i class="far fa-fw fa-comments"></i>
                  <span class="icon-label">Kontakt</span>
                </a>
                <div class="dropdown-menu" x-placement="bottom-start">
                  <ul>
                    <li>
                      <a href="tel:+492011834031">
                        <i class="far fa-fw fa-phone"></i>
                        +49 201 18 34031
                      </a>
                    </li>
                    <li>
                      <a href="/">
                        <i class="far fa-fw fa-envelope"></i>
                        sekretariat.softec@paluno.uni-due.de
                      </a>
                    </li>
                    <li>
                      <a href="/kontakt/anfahrt-und-postanschrift/">
                        <i class="far fa-fw fa-map-signs"></i>
                        Anfahrt und Postanschrift
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              <li id="navigationStakeholder">
                <a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  <i class="far fa-fw fa-user"></i>
                  <span class="icon-label">Informationen der UDE für...</span>
                </a>
                <ul class="dropdown-menu">
                  <li>
                    <a href="https://www.uni-due.de/de/interessierte.php">Studieninteressierte</a>
                  </li>
                  <li>
                    <a href="https://www.uni-due.de/de/studierende.php">Studierende</a>
                  </li>
                  <li>
                    <a href="https://www.uni-due.de/de/promovierende.php">Promovierende</a>
                  </li>
                  <li>
                    <a href="https://www.uni-due.de/de/alumni/">Alumni</a>
                  </li>
                  <li>
                    <a href="https://www.uni-due.de/verwaltung/beschaeftigte.php">Beschäftige</a>
                  </li>
                  <li>
                    <a href="https://www.uni-due.de/de/wirtschaft/">Wirtschaft</a>
                  </li>
                  <li>
                    <a href="https://www.uni-due.de/de/presse/index.php">Presse</a>
                  </li>
                  <li>
                    <a href="https://www.uni-due.de/international/">International</a>
                  </li>
                </ul>
              </li>
            </ul>
          </nav>
          <nav class="col col-auto">
            <a href="#" class="social-toggler" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" role="button" id="socialDropDownButton">
              <i class="far fa-fw fa-share-square" aria-hidden="true"></i>
              <span class="icon-label">Social Media</span>
            </a>
            <div class="dropdown-menu dropdown-menu-right" id="navigationSocialContent" aria-labelledby="socialDropDownButton">
              <ul>
                <li>
                  <a href="https://www.uni-due.de/myude/" class="social social-myude" title="myUDE">
                    <i class="fab fa-fw fa-myude" aria-hidden="true"></i>
                  </a>
                </li>
                <li>
                  <a href="http://www.facebook.com/uni.due" class="social social-facebook" title="Facebook">
                    <i class="fab fa-fw fa-facebook-f" aria-hidden="true"></i>
                  </a>
                </li>
                <li>
                  <a href="http://twitter.com/unidue" class="social social-twitter" title="Twitter">
                    <i class="fab fa-fw fa-twitter" aria-hidden="true"></i>
                  </a>
                </li>
                <li>
                  <a href="https://www.softec.wiwi.uni-due.de/rss/" class="social social-rss" title="RSS">
                    <i class="fab fa-fw fa-rss" aria-hidden="true"></i>
                  </a>
                </li>
              </ul>
            </div>
          </nav>
          <nav class="col col-auto">
            <div class="nav nav-pills">
              <xsl:call-template name="layout.login"/>
            </div>
          </nav>
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="layout.header">
    <header class="bg-white">
      <div class="container py-3" id="siteHeader">
        <div class="row">
          <div class="col">
            <a class="containsimage" id="ude-logo" href="https://www.uni-due.de/">
              <img src="{$WebApplicationBaseURL}images/ude-logo.png" alt="Logo" />
            </a>
          </div>

          <div class="col-6" id="orgaunitTitle">
            <h1 class="text-muted">
              <a href="https://www.uni-due.de/">Lehrstuhl für Wirtschaftsinformatik und Softwaretechnik</a>
            </h1>
            <h2>
              Prof. Dr. Max Musterfrau
            </h2>
          </div>

          <div class="col" id="orgaunitLogo">
            <a href="/">
              <img src="https://www.softec.wiwi.uni-due.de/fileadmin/fileupload/WI-SOFTEC/SOFTEC-logo.svg" alt=""/>
            </a>
          </div>

        </div>
      </div>
    </header>
  </xsl:template>

  <xsl:template name="layout.basket.info">
    <div id="basket-info" class="card border-0">
      <div class="card-body py-1">
	<a href="{$ServletsBaseURL}MCRBasketServlet?action=show&amp;type=bibentries">
          <span class="glyphicon glyphicon-bookmark mr-1" aria-hidden="true" />
          <span class="mr-1"><xsl:value-of select="i18n:translate('basket')" />:</span>
          <span class="mr-1" id="basket-info-num">
            <xsl:value-of xmlns:basket="xalan://unidue.ubo.basket.BasketUtils" select="basket:size()" />
          </span>
          <span class="mr-1"><xsl:value-of select="i18n:translate('ubo.publications')" /></span>
	</a>
      </div>
    </div>
  </xsl:template>

  <!-- page content -->

  <xsl:template name="layout.inhalt">
    <section role="main" id="inhalt">
    
      <xsl:choose>
        <xsl:when test="$allowed.to.see.this.page = 'true'">
          <xsl:copy-of select="body/*[not(@id='sidebar')][not(@id='breadcrumb')]" />
        </xsl:when>
        <xsl:otherwise>
          <h3>
            <xsl:value-of select="i18n:translate('navigation.notAllowedToSeeThisPage')" />
          </h3>
        </xsl:otherwise>
      </xsl:choose>
    </section>
  </xsl:template>

  <!-- Brotkrumen-Navigation -->

  <xsl:template name="layout.breadcrumbPath">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb py-1">
        <li class="breadcrumb-item">
          <a href="https://www.uni-due.de/ub/">
            <xsl:value-of select="i18n:translate('navigation.UB')" />
          </a>
        </li>
        <li class="breadcrumb-item">
          <a href="{$WebApplicationBaseURL}">
            <xsl:value-of select="i18n:translate('navigation.Home')" />
          </a>
        </li>
        <xsl:apply-templates mode="breadcrumb"
                             select="$CurrentItem/ancestor-or-self::item[@label|label][ancestor-or-self::*=$navigation.tree[@role='main']]" />
        <xsl:for-each select="body/ul[@id='breadcrumb']/li">
          <li class="breadcrumb-item">
              <xsl:copy-of select="node()" />
          </li>
        </xsl:for-each>
      </ol>
    </nav>
  </xsl:template>

  <xsl:template match="item" mode="breadcrumb">
    <li class="breadcrumb-item">
      <xsl:call-template name="output.item.label" />
    </li>
  </xsl:template>

  <!-- Ausgabe Link und Bezeichnung des Menüpunktes -->

  <xsl:template name="output.item.label">
    <xsl:choose>

      <!-- ==== link to external url ==== -->
      <xsl:when test="@href">
        <a class="nav-link" href="{@href}">
          <xsl:copy-of select="@target" />
          <xsl:call-template name="output.label.for.lang" />
        </a>
      </xsl:when>

      <!-- ==== link to internal url ==== -->
      <xsl:when test="@ref">
        <a class="nav-link" href="{$WebApplicationBaseURL}{@ref}">
          <xsl:copy-of select="@target" />
          <xsl:call-template name="output.label.for.lang" />
        </a>
      </xsl:when>

      <!-- no link -->
      <xsl:otherwise>
        <xsl:call-template name="output.label.for.lang" />
      </xsl:otherwise>

    </xsl:choose>

  </xsl:template>

  <!-- print label in current language -->

  <xsl:template name="output.label.for.lang">
    <xsl:choose>
      <xsl:when test="label[lang($CurrentLang)]">
        <xsl:value-of select="label[lang($CurrentLang)]" />
      </xsl:when>
      <xsl:when test="label[lang($DefaultLang)]">
        <xsl:value-of select="label[lang($DefaultLang)]" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@label" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- current user and login formular-->
  <xsl:template name="layout.login">

    <div class="nav-item mr-2">
      <span class="user btn p-0" style="cursor: default;">
        <xsl:text>[ </xsl:text>
        <xsl:choose>
          <xsl:when test="$CurrentUser = $MCR.Users.Guestuser.UserName">
            <xsl:value-of select="i18n:translate('component.user2.login.guest')" />
          </xsl:when>
          <xsl:when test="contains($CurrentUser,'@')">
            <a href="{$ServletsBaseURL}MCRUserServlet?action=show" style="text-decoration: none;">
              <xsl:value-of select="substring-before($CurrentUser,'@')" />
            </a>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$CurrentUser" />
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text> ]</xsl:text>

        <xsl:call-template name="orcidUser" />        
      </span>
    </div>
    <div class="nav-item mr-2">
      <xsl:choose>
        <xsl:when test="/webpage/@id='login'" />
        <xsl:when test="$CurrentUser = $MCR.Users.Guestuser.UserName">
          <form action="{$WebApplicationBaseURL}login.xed" method="get">
            <input type="hidden" name="url" value="{$RequestURL}" />
            <input class="btn btn-link p-0" type="submit" name="{i18n:translate('component.user2.button.login')}" value="{i18n:translate('component.user2.button.login')}" />
          </form>
        </xsl:when>
        <xsl:otherwise>
          <form action="{$ServletsBaseURL}logout" method="get">
            <input type="hidden" name="url" value="{$RequestURL}" />
            <input class="btn btn-link p-0" style="border:0;" type="submit" name="{i18n:translate('login.logOut')}" value="{i18n:translate('login.logOut')}" />
          </form>
        </xsl:otherwise>
      </xsl:choose>
    </div>
    <div class="nav-item">
      <span class="btn p-0">
        <a>
          <xsl:attribute name="href">
            <xsl:choose>
              <xsl:when test="$CurrentLang='de'">
                <xsl:call-template name="UrlSetParam">
                  <xsl:with-param name="url" select="$RequestURL" />
                  <xsl:with-param name="par" select="'lang'" />
                  <xsl:with-param name="value" select="'en'" />
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="$CurrentLang='en'">
                <xsl:call-template name="UrlSetParam">
                  <xsl:with-param name="url" select="$RequestURL" />
                  <xsl:with-param name="par" select="'lang'" />
                  <xsl:with-param name="value" select="'de'" />
                </xsl:call-template>
              </xsl:when>
            </xsl:choose>
          </xsl:attribute>
          <img src="{$WebApplicationBaseURL}images/lang_{$CurrentLang}.gif" alt="{i18n:translate('navigation.Language')}" />
          <xsl:value-of select="i18n:translate('navigation.ende')"/>
        </a>
      </span>
    </div>

  </xsl:template>

  <!-- If current user has ORCID and we are his trusted party, display ORCID icon to indicate that -->  
  <xsl:param name="MCR.ORCID.LinkURL" />

  <xsl:template name="orcidUser">

    <xsl:variable name="orcidUser" select="orcidSession:getCurrentUser()" xmlns:orcidSession="xalan://org.mycore.orcid.user.MCRORCIDSession" />
    <xsl:variable name="userStatus" select="orcidUser:getStatus($orcidUser)" xmlns:orcidUser="xalan://org.mycore.orcid.user.MCRORCIDUser" />
    <xsl:variable name="trustedParty" select="userStatus:weAreTrustedParty($userStatus)" xmlns:userStatus="xalan://org.mycore.orcid.user.MCRUserStatus" />
    
    <xsl:if test="$trustedParty = 'true'">
      <xsl:variable name="orcid" select="orcidUser:getORCID($orcidUser)" xmlns:orcidUser="xalan://org.mycore.orcid.user.MCRORCIDUser" />
      <a href="{$MCR.ORCID.LinkURL}{$orcid}">
        <img alt="ORCID {$orcid}" src="{$WebApplicationBaseURL}images/orcid_icon.svg" class="orcid-icon" />
      </a>
    </xsl:if>
  </xsl:template>

  <!-- Menüpunkt im Navigationsmenü -->
  <xsl:template match="item" mode="navigation">

    <!-- ==== Prüfe ob aktueller Benutzer berechtigt ist, diesen Menüpunkt zu sehen ==== -->
    <xsl:variable name="allowed">
      <xsl:call-template name="check.allowed" />
    </xsl:variable>

    <!-- add class="active for selected items" -->
    <xsl:variable name="class_active">
      <xsl:if test="@id and (@id = $PageID)">
        <xsl:value-of select="'active'"/>
      </xsl:if>
      <xsl:if test="./item[@id = $PageID]">
        <xsl:value-of select="'active'"/>
      </xsl:if>
    </xsl:variable>

    <xsl:if test="$allowed = 'true'">

      <xsl:choose>
        <xsl:when test="count(./item/@ref) &gt; 0">
          <!-- print dropdown menu option -->
          <li class="nav-item dropdown {$class_active}">
            <xsl:if test="@class != ''">
              <xsl:attribute name="class">
                <xsl:value-of select="concat('nav-item dropdown', $class_active, ' ', @class)"/>
              </xsl:attribute>
            </xsl:if>
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
               aria-haspopup="true" aria-expanded="false">
              <xsl:call-template name="output.label.for.lang" />
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <xsl:for-each select="./item">
                <a class="dropdown-item" href="{@ref}">
                  <xsl:copy-of select="@target" />
                  <xsl:call-template name="output.label.for.lang" />
                </a>
              </xsl:for-each>
            </div>
          </li>
        </xsl:when>
        <xsl:otherwise>
          <!-- print single menu option -->
          <li class="nav-item {$class_active}">
            <xsl:if test="@class != ''">
              <xsl:attribute name="class">
                <xsl:value-of select="concat('nav-item ', $class_active, ' ', @class)"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:call-template name="output.item.label"/>
          </li>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>

  </xsl:template>

  <xsl:template name="layout.pageTitle">
    <div class="card my-3">
      <div class="card-body py-2">
        <h3 id="seitentitel">
          <xsl:value-of select="head/title" disable-output-escaping="yes" />
        </h3>
      </div>
    </div>
  </xsl:template>
  
  <!-- Footer -->

  <xsl:template name="layout.footer">
    <footer>
      <div class="container py-4">
        <div class="row">
          <div class="col col-md-4">
            <h2 class="card-title">SOFTEC-Lehrstuhl</h2>
            <div class="csc-textpic csc-textpic-left csc-textpic-above">
              <div class="csc-textpic-imagewrap" data-csc-images="1" data-csc-cols="2">
                <figure class="csc-textpic-image csc-textpic-last">
                  <img src="https://static.wiwi.uni-due.de/user-upload/SOFTEC-logo-mono.svg" width="300" height="82" alt=""/>
                </figure>
              </div>
            </div>
          </div>
          <div class="col col-md-4">
            <xsl:value-of select="document('webapp:contact.xml')//article[lang($CurrentLang)]"/>
          </div>
          <div class="col col-md-4">
            <h2 class="card-title">Mitgliedschaften</h2>
            <ul>
              <li>
                <a href="https://www.wiwi.uni-due.de">Fakultät für Wirtschaftswissenschaften</a>
              </li>
              <li>
                <a href="https://www.wi.wiwi.uni-due.de/home/">Fachgebiet Wirtschaftsinformatik</a>
              </li>
              <li>
                <a href="https://www.icb.uni-due.de">Institut für Informatik und Wirtschaftsinformatik (ICB)</a>
              </li>
              <li>
                <a href="https://paluno.uni-due.de/">paluno - The Ruhr Institute for Software Technology</a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <xsl:call-template name="layout.imprintline"/>
    </footer>
  </xsl:template>

  <!-- Imprintline (below footer) -->
  <xsl:template name="layout.imprintline">
    <div class="imprintlinewrapper">
      <div class="container py-4">
        <div class="row">
          <div class="col" id="footerLogo">
            <a href="https://www.uni-due.de/">
              <img src="https://static.wiwi.uni-due.de/ude2018/Images/UDE-logo-claim-dark.svg" width="1052" height="414" alt="" />
            </a>
          </div>
          <div class="col col-md-auto justify-content-end">
            <nav id="navigationFooter" class="navbar">
              <ul>
                <li>
                  <a href="https://www.uni-due.de/infoline/">
                    <i class="fa fa-fw fa-phone"></i>Infoline
                  </a>
                </li>
                  <li>
                    <a href="https://www.uni-due.de/de/hilfe_im_notfall.php">
                      <i class="fa fa-fw fa-exclamation-triangle"></i>Hilfe im Notfall
                    </a>
                  </li>
                  <li>
                    <a href="/sitemap/">
                      <i class="fa fa-fw fa-sitemap"></i>Sitemap
                    </a>
                  </li>
                  <li>
                    <a href="/datenschutz/">
                      <i class="fa fa-fw fa-user-shield"></i>Datenschutz
                    </a>
                  </li>
                  <li>
                    <a href="/impressum/">
                      <i class="fa fa-fw fa-file-alt"></i>Impressum
                    </a>
                  </li>
              </ul>
            </nav>
            <div id="footerCopyright" class="navbar">
                <ul class="nav">
                    <li>© Universität Duisburg-Essen</li>
                    <li><xsl:apply-templates select="/html/@lastModified" /></li>
                </ul>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>

  <!-- Optional: Datum der letzten Änderung dieser Seite im Format YYYY-MM-TT -->

  <xsl:template match="/html/@lastModified">
    <xsl:value-of select="i18n:translate('webpage.modified')" />
    <xsl:text>: </xsl:text>
    <xsl:choose>
      <xsl:when test="$CurrentLang = 'de'">
        <xsl:value-of select="substring(.,9,2)" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="substring(.,6,2)" />
        <xsl:text>.</xsl:text>
        <xsl:value-of select="substring(.,1,4)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="." />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text> | </xsl:text>
  </xsl:template>

  <!-- Meta-Navigation -->

  <xsl:template name="layout.metanav">
    <xsl:variable name="metanavigation" select="$navigation.tree/item[@role='meta']/item"/>
    <nav class="navbar navbar navbar-expand">
      <ul class="navbar-nav">
        <!-- Find the item that is the root of the navigation tree to display -->
        <xsl:for-each select="$metanavigation" >
          <xsl:choose>
            <!-- There is an item that should be displayed as root of the tree -->
            <xsl:when test="name()='item'">
              <xsl:apply-templates select="." mode="navigation" />
            </xsl:when>
            <!-- Display the complete navigation tree down from top -->
            <xsl:otherwise>
              <xsl:apply-templates select="item[@label|label]" mode="navigation" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </ul>
    </nav>
  </xsl:template>

  <!-- print out message that the system is in read only mode -->

  <xsl:param name="UBO.System.ReadOnly.Message" />
  <xsl:template name="local.readonly.message">
    <xsl:if test="($WritePermission = 'true') and ($UBO.System.ReadOnly = 'true')">
      <div class="section">
        <span style="color:red">
          <xsl:value-of select="$UBO.System.ReadOnly.Message" />
        </span>
      </div>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
