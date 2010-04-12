<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output 
     method="html" 
     indent="yes" 
     doctype-public="-//W3C//DTD HTML 4.01//EN" 
     doctype-system="http://www.w3.org/TR/html4/strict.dtd"
     encoding="ISO-8859-1" />

  <xsl:param name="filename"/>

  <!-- <xsl:template match="processing-instruction()">
       </xsl:template> -->

  <!-- Copy all html4 elements over to the resulting html page -->
  <xsl:template match=" a | abbr | acronym | address | applet | area | b | base | basefont | 
                       bdo | big | blockquote  | body | br | button | caption | center | cite | code | col | 
                       colgroup | dd | del | dfn | dir | div | dl | dt | em | fieldset     | font | form | 
                       frame | frameset | h1 | h2 | h3 | h4 | h5 | h6 | head | hr | html | i | iframe | img | 
                       input | ins | isindex    | kbd | label | legend | li | link | map | menu | meta | 
                       noframes | noscript | object | ol | optgroup | option | p     | param | pre | q | s | 
                       samp | script | select | small | span | strike | strong | style | sub | sup | table | 
                       tbody | td | textarea | tfoot | th | thead | title | tr | tt | u | ul | var">

    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>

  <!-- Error out on all unknown tags -->
  <xsl:template match="*">
    <xsl:message terminate="yes">
      <xsl:text>Found unknown tag: </xsl:text>
      <xsl:text>"</xsl:text><xsl:value-of select="name()"/><xsl:text>"</xsl:text>
      <xsl:value-of select="." />
    </xsl:message>
  </xsl:template>
  
  <xsl:template match="dlink">
    <a href="{@href}"><xsl:value-of select="@href" /></a>
  </xsl:template> 

  <xsl:template name="menuitem">
    <xsl:param name="name"/>    
    <xsl:param name="lowername"/>

    <xsl:choose>
      <xsl:when test="$filename = $lowername">
        <div><a class="currentmenuitem" href="{.}.html"><xsl:value-of select="."/></a></div>
      </xsl:when>
      <xsl:otherwise>
        <div><a class="menuitem" href="{.}.html"><xsl:value-of select="."/></a></div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="page">
    <html>
      <head>
        <title>Pingus - <xsl:value-of select="@title" /></title>
        <link rel="stylesheet" type="text/css" href="default.css" />
        <link rel="shortcut icon" href="images/favicon.png" type="image/png" />
      </head>
      <body>
        <div id="pagebody">
          <div id="title">
            <div style="display: inline; float: right; margin: 0; padding: 0; position: absolute; right: 1em; top: 1em;">
              <form action="https://www.paypal.com/cgi-bin/webscr" method="post">
                <div style="margin: 0px; padding: 0px;">
                  <input type="hidden" name="cmd" value="_xclick" />
                  <input type="hidden" name="business" value="grumbel@gmx.de" />
                  <input type="hidden" name="item_name" value="Pingus donation" />
                  <input type="hidden" name="no_note" value="1" />
                  <input type="hidden" name="currency_code" value="EUR" />
                  <input type="hidden" name="tax" value="0" />
                  <input type="image" src="http://www.paypal.com/en_US/i/btn/btn_donate_LG.gif" name="submit" alt="donate via PayPal" />
                </div>
              </form>
            </div>

            <a href="http://pingus.seul.org"><img src="images/logo_pingus.png" alt="Pingus" /></a>
          </div>

          <div class="nav">
            <ul>
              <li><a class="menuitem" href="news.html">News</a></li>
              <li><a class="menuitem" href="welcome.html">Welcome</a></li>
              <li><a class="menuitem" href="download.html">Download</a></li>
              <li><a class="menuitem" href="faq.html">FAQ</a></li>
              <li><a class="menuitem" href="contact.html">Contact</a></li>
              <li><a class="menuitem" href="screenshots.html">Screenshots</a></li>
              <!-- <li><a class="menuitem" href="level_comment_tool/index.php">Level Comment Tool</a></li> -->
              <!-- <li><a class="menuitem" href="development.html">Development</a></li> -->
              <li><a class="menuitem" href="press.html">Press</a></li>
              <!-- <li><a class="menuitem" href="http://savannah.nongnu.org/projects/pingus/">Development</a></li> -->
            </ul>
          </div>
          
          <h1><xsl:value-of select="@title"/></h1>
          <div class="mainbody">
            <xsl:apply-templates />
          </div>             
          <div class="footer">
            Copyright &#169; 1998-2010 <a href="http://pingus.seul.org/~grumbel/">Ingo Ruhnke</a>, &lt;<a href="mailto:grumbel@gmx.de">grumbel@gmx.de</a>&gt;
          </div>
          <p style="text-align: center;">
            <a href="http://validator.w3.org/check/referer">html4</a>/
            <a href="http://jigsaw.w3.org/css-validator/">css2</a>
          </p>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="section">
    <h2><xsl:value-of select="@title" /></h2>
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template match="subsection">
    <h3><xsl:value-of select="@title" /></h3>
    <xsl:apply-templates />
  </xsl:template>
  
  <xsl:template match="screenshots">
    <table summary="" width="100%" border="0" cellpadding="0"  cellspacing="0">
      
      <tr>
        <td align="center">
          <xsl:apply-templates select="item[1]"/>
        </td>
        <td align="center">
          <xsl:apply-templates select="item[2]"/>
        </td>
        <td align="center">
          <xsl:apply-templates select="item[3]"/>
        </td>
      </tr>

      <xsl:if test="count(item)>3">
        <tr>
          <td align="center">
            <xsl:apply-templates select="item[4]"/>
          </td>
          <td align="center">
            <xsl:apply-templates select="item[5]"/>
          </td>
          <td align="center">
            <xsl:apply-templates select="item[6]"/>
          </td>
        </tr>
      </xsl:if>


      <xsl:if test="count(item)>6">
        <tr>
          <td align="center">
            <xsl:apply-templates select="item[7]"/>
          </td>
          <td align="center">
            <xsl:apply-templates select="item[8]"/>
          </td>
          <td align="center">
            <xsl:apply-templates select="item[9]"/>
          </td>
        </tr>
      </xsl:if>

    </table>
  </xsl:template>

  <xsl:template match="screenshots/item">
    <a href="images/{@file}.jpg"><img class="screenshot" alt="{@file}" src="images/{@file}_small.jpg" title="{.}"/></a>
  </xsl:template>

  <xsl:template match="screenshot-menu">
    <p style="text-align: center; margin-top: 0em;">
      [ 
      <a href="screenshots.html">0.7</a>
      |
      <a href="screenshots-0.6.html">0.6</a>
      |
      <a href="screenshots-0.5.html">0.5</a>
      |
      <a href="screenshots-0.4.html">0.4</a>
      |
      <a href="screenshots-0.3.html">0.3</a>
      |
      <a href="screenshots-0.2.html">0.2</a>
      |
      <a href="screenshots-0.1.html">0.1</a>
      |
      <a href="screenshots-0.0.html">0.0</a>
      ]
    </p>
  </xsl:template>

  <xsl:template match="netstat-image">
    <div style="text-align: right;">
      <!-- Begin Nedstat Basic code -->
      <!-- Title: Pingus -->
      <!-- URL: http://dark.x.dtu.dk/~grumbel/pingus/index.html -->
      <script type="text/javascript" language="JavaScript" src="http://m1.nedstatbasic.net/basic.js">
      </script>

      <script type="text/javascript" language="JavaScript">
        <xsl:comment>
          nedstatbasic("AAG6CQE7r43v+PiFyrKmmmG/C9Lg", 0);
          // </xsl:comment>
      </script>
      <noscript>
        <a target="_blank" href="http://v1.nedstatbasic.net/stats?AAG6CQE7r43v+PiFyrKmmmG/C9Lg"><img
                                                                                                   src="http://m1.nedstatbasic.net/n?id=AAG6CQE7r43v+PiFyrKmmmG/C9Lg"   
                                                                                                   border="0" width="18" height="18" alt="" /></a>
      </noscript>
      <!-- End Nedstat Basic code -->
    </div>
  </xsl:template>

  <xsl:template match="section-toc">
    <ul>
      <xsl:for-each select="section">
        <li><a href="#section{generate-id(.)}">
            <xsl:apply-templates/></a></li>
      </xsl:for-each>
    </ul>
    <hr/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="faq-list">
    <ul>
      <xsl:for-each select="faq/question">
        <li><a href="#faq{generate-id(.)}">
            <xsl:apply-templates/></a></li>
      </xsl:for-each>
    </ul>
    <hr/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="faq">
    <p></p>
    <table width="100%"  class="question">
      <colgroup width="60%" />
      <tr><td valign="top">
          <div id="faq{generate-id(question)}">
            <xsl:apply-templates select="question/node()"/>
          </div>
        </td>
        
        
        <td align="right" valign="top">
          <small>Last update:<xsl:value-of select="@date"/></small>
          [<small><a href="#faqtoc">Up</a></small>]
        </td>
      </tr>
    </table>

    <p class="answer"><xsl:apply-templates select="answer/node()"/> </p>
  </xsl:template>

  <xsl:template match="news">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="news/item">
    <div class="newsitem">
      <div class="newsdate"><xsl:value-of select="@date"/></div>
      <div class="newsbody"><xsl:apply-templates/></div>
    </div>
  </xsl:template>

  <xsl:template match="german-flag">
    (german)
  </xsl:template>

  <xsl:template match="english-flag">
    (english)
  </xsl:template>

  <xsl:template match="dutch-flag">
    (dutch)
  </xsl:template>

</xsl:stylesheet>
