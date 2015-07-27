" Vim syntax file
"      Language: JavaScript
"    Maintainer: Jose Elera Campana <https://github.com/jelera>
" Last Modified: Sun 26 Jul 2015 08:34:33 PM CDT
"       Version: 1.0a
"       Changes: Go to https://github.com/jelera/vim-javascript-syntax for
"                recent changes.
"       Credits: Zhao Yi, Claudio Fleiner, Scott Shattuck (This file is based
"                on their hard work), gumnos (From the #vim IRC Channel in
"                Freenode)

if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'javascript'
endif

" Drop fold if it set but vim doesn't support it.
if version < 600 && exists("javaScript_fold")
	unlet javaScript_fold
endif

"" dollar sign is permitted anywhere in an identifier
setlocal iskeyword+=$

"" Remove dollar sign from identifier when embedded in a PHP file
if &filetype == 'php'
	setlocal iskeyword-=$
endif

syntax sync fromstart

"" syntax coloring for Node.js shebang line
syntax match shebang "^#!.*"
hi link shebang Comment

" Statement Keywords {{{
syntax keyword javascriptSource         import export
syntax keyword javascriptIdentifier     arguments this let var void yield
syntax keyword javascriptOperator       delete new instanceof typeof
syntax keyword javascriptBoolean        true false
syntax keyword javascriptNull           null undefined
syntax keyword javascriptMessage        alert confirm prompt status
syntax keyword javascriptGlobal         self top parent
syntax keyword javascriptDeprecated     escape unescape all applets alinkColor bgColor fgColor linkColor vlinkColor xmlEncoding
syntax keyword javascriptConditional    if else switch
syntax keyword javascriptRepeat         do while for in
syntax keyword javascriptBranch         break continue
syntax keyword javascriptLabel          case default
syntax keyword javascriptPrototype      prototype
syntax keyword javascriptStatement      return with
syntax keyword javascriptGlobalObjects  Array Boolean Date Function Math Number Object RegExp String
syntax keyword javascriptExceptions     try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
syntax keyword javascriptReserved       abstract enum int short boolean export interface static byte extends long super char final native synchronized class float package throws const goto private transient debugger implements protected volatile double import public
"}}}
" Comments {{{
syntax keyword javascriptCommentTodo      TODO FIXME XXX TBD contained
syntax match   javascriptLineComment      "\/\/.*" contains=@Spell,javascriptCommentTodo
syntax match   javascriptCommentSkip      "^[ \t]*\*\($\|[ \t]\+\)"
syntax region  javascriptComment          start="/\*"  end="\*/" contains=@Spell,javascriptCommentTodo
"}}}
" JSDoc support {{{
if !exists("javascript_ignore_javascriptdoc")
	syntax case ignore

	" syntax coloring for JSDoc comments (HTML)
	"unlet b:current_syntax

	syntax region JSDocComment        matchgroup=javascriptComment start="/\*\*\s*$"  end="\*/" contains=JSDocTags,javascriptCommentTodo,@javascriptHtml,jsInJsdocExample,@Spell fold
	syntax match  JSDocTags           contained "@\(param\|argument\|returns\=\|requires\|exception\|throws\|type\|class\|extends\|see\|link\|member\|module\|method\|title\|namespace\|name\|memberof\|exports\|callback\|typedef\|property\|optional\|default\|base\|file\)\>" nextgroup=JSDocParam,JSDocSeeTag skipwhite
	syntax match  JSDocTags           contained "@\(beta\|deprecated\|description\|fileoverview\|author\|license\|version\|constructor\|private\|protected\|final\|ignore\|addon\|exec\)\>"
	syntax match  JSDocParam          contained "\%(#\|\w\|\.\|:\|\/\)\+"
	syntax region JSDocSeeTag         contained matchgroup=JSDocSeeTag start="{" end="}" contains=JSDocTags

	syntax case match
endif
	syntax case match
"}}}
" Strings, Numbers and Regex Highlight {{{
syntax match   javascriptSpecial          "\\\d\d\d\|\\."
syntax region  javascriptString           start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=javascriptSpecial,@htmlPreproc
syntax region  javascriptString           start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=javascriptSpecial,@htmlPreproc

syntax match   javascriptSpecialCharacter "'\\.'"
syntax match   javascriptNumber           "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syntax region  javascriptRegexpString     start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
syntax match   javascriptFloat          /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/
"}}}
"  DOM, Browser and Ajax Support   {{{
syntax keyword javascriptBrowserObjects           window navigator screen history location

syntax keyword javascriptDOMObjects               document event HTMLElement Anchor Area Base Body Button Form Frame Frameset Image Link Meta Option Select Style Table TableCell TableRow Textarea
syntax keyword javascriptDOMMethods               createTextNode createElement insertBefore replaceChild removeChild appendChild  hasChildNodes  cloneNode  normalize  isSupported  hasAttributes  getAttribute  setAttribute  removeAttribute  getAttributeNode  setAttributeNode  removeAttributeNode  getElementsByTagName  hasAttribute  getElementById adoptNode close compareDocumentPosition createAttribute createCDATASection createComment createDocumentFragment createElementNS createEvent createExpression createNSResolver createProcessingInstruction createRange createTreeWalker elementFromPoint evaluate getBoxObjectFor getElementsByClassName getSelection getUserData hasFocus importNode
syntax keyword javascriptDOMProperties            nodeName  nodeValue  nodeType  parentNode  childNodes  firstChild  lastChild  previousSibling  nextSibling  attributes  ownerDocument  namespaceURI  prefix  localName  tagName

syntax keyword javascriptAjaxObjects              XMLHttpRequest
syntax keyword javascriptAjaxProperties           readyState responseText responseXML statusText
syntax keyword javascriptAjaxMethods              onreadystatechange abort getAllResponseHeaders getResponseHeader open send setRequestHeader

syntax keyword javascriptPropietaryObjects        ActiveXObject
syntax keyword javascriptPropietaryMethods        attachEvent detachEvent cancelBubble returnValue

syntax keyword javascriptHtmlElemProperties       className  clientHeight  clientLeft  clientTop  clientWidth  dir  href  id  innerHTML  lang  length  offsetHeight  offsetLeft  offsetParent  offsetTop  offsetWidth  scrollHeight  scrollLeft  scrollTop  scrollWidth  style  tabIndex  target  title

syntax keyword javascriptEventListenerKeywords    blur click focus mouseover mouseout load item

syntax keyword javascriptEventListenerMethods     scrollIntoView  addEventListener  dispatchEvent  removeEventListener preventDefault stopPropagation
" }}}
" DOM/HTML5/CSS specified things {{{
	" Web API Interfaces (very long list of keywords) {{{
	" syntax keyword javascriptWebAPI  AbstractWorker AnalyserNode AnimationEvent App Apps ArrayBuffer ArrayBufferView Attr AudioBuffer AudioBufferSourceNode AudioContext AudioDestinationNode AudioListener AudioNode AudioParam AudioProcessingEvent BatteryManager BiquadFilterNode Blob BlobBuilder BlobEvent CallEvent CameraCapabilities CameraControl CameraManager CanvasGradient CanvasImageSource CanvasPattern CanvasPixelArray CanvasRenderingContext2D CaretPosition CDATASection ChannelMergerNode ChannelSplitterNode CharacterData ChildNode ChromeWorker ClipboardEvent CloseEvent Comment CompositionEvent Connection Console ContactManager ConvolverNode Coordinates CSS CSSConditionRule CSSGroupingRule CSSKeyframeRule CSSKeyframesRule CSSMediaRule CSSNamespaceRule CSSPageRule CSSRule CSSRuleList CSSStyleDeclaration CSSStyleRule CSSStyleSheet CSSSupportsRule CustomEvent
	" syntax keyword javascriptWebAPI  DataTransfer DataView DedicatedWorkerGlobalScope DelayNode DeviceAcceleration DeviceLightEvent DeviceMotionEvent DeviceOrientationEvent DeviceProximityEvent DeviceRotationRate DeviceStorage DeviceStorageChangeEvent DirectoryEntry DirectoryEntrySync DirectoryReader DirectoryReaderSync Document DocumentFragment DocumentTouch DocumentType DOMConfiguration DOMCursor DOMError DOMErrorHandler DOMException DOMHighResTimeStamp DOMImplementation DOMImplementationList DOMImplementationSource DOMLocator DOMObject DOMParser DOMRequest DOMString DOMStringList DOMStringMap DOMTimeStamp DOMTokenList DOMUserData DynamicsCompressorNode
	" syntax keyword javascriptWebAPI  Element ElementTraversal Entity EntityReference Entry EntrySync ErrorEvent Event EventListener EventSource EventTarget Extensions File FileEntry FileEntrySync FileError FileException FileList FileReader FileSystem FileSystemSync Float32Array Float64Array FMRadio FocusEvent FormData GainNode Geolocation History
	" syntax keyword javascriptWebAPI  HTMLAnchorElement HTMLAreaElement HTMLAudioElement HTMLBaseElement HTMLBaseFontElement HTMLBodyElement HTMLBRElement HTMLButtonElement HTMLCanvasElement HTMLCollection HTMLDataElement HTMLDataListElement HTMLDivElement HTMLDListElement HTMLDocument HTMLElement HTMLEmbedElement HTMLFieldSetElement HTMLFormControlsCollection HTMLFormElement HTMLHeadElement HTMLHeadingElement HTMLHRElement HTMLHtmlElement HTMLIFrameElement HTMLImageElement HTMLInputElement HTMLIsIndexElement HTMLKeygenElement HTMLLabelElement HTMLLegendElement HTMLLIElement HTMLLinkElement HTMLMapElement HTMLMediaElement HTMLMetaElement HTMLMeterElement HTMLModElement HTMLObjectElement HTMLOListElement HTMLOptGroupElement HTMLOptionElement HTMLOptionsCollection HTMLOutputElement HTMLParagraphElement HTMLParamElement HTMLPreElement HTMLProgressElement HTMLQuoteElement HTMLScriptElement HTMLSelectElement HTMLSourceElement HTMLSpanElement HTMLStyleElement HTMLTableCaptionElement HTMLTableCellElement HTMLTableColElement HTMLTableElement HTMLTableRowElement HTMLTableSectionElement HTMLTextAreaElement HTMLTimeElement HTMLTitleElement HTMLTrackElement HTMLUListElement HTMLUnknownElement HTMLVideoElement
	" syntax keyword javascriptWebAPI  IDBCursor IDBCursorWithValue IDBDatabase IDBDatabaseException IDBEnvironment IDBFactory IDBIndex IDBKeyRange IDBObjectStore IDBOpenDBRequest IDBRequest IDBTransaction IDBVersionChangeEvent ImageData Int16Array Int32Array Int8Array KeyboardEvent LinkStyle LocalFileSystem LocalFileSystemSync Location MediaQueryList MediaQueryListListener MediaSource MediaStream MediaStreamTrack MessageEvent MouseEvent MouseScrollEvent MouseWheelEvent MozActivity MozActivityOptions MozActivityRequestHandler MozAlarmsManager MozContact MozContactChangeEvent MozIccManager MozMmsEvent MozMmsMessage MozMobileCellInfo MozMobileCFInfo MozMobileConnection MozMobileConnectionInfo MozMobileICCInfo MozMobileMessageManager MozMobileMessageThread MozMobileNetworkInfo MozNetworkStats MozNetworkStatsData MozNetworkStatsManager MozSettingsEvent MozSmsEvent MozSmsFilter MozSmsManager MozSmsMessage MozSmsSegmentInfo MozTimeManager MozWifiConnectionInfoEvent MutationObserver
	" syntax keyword javascriptWebAPI  NamedNodeMap NameList Navigator NavigatorGeolocation NavigatorID NavigatorLanguage NavigatorOnLine NavigatorPlugins NetworkInformation Node NodeFilter NodeIterator NodeList Notation Notification NotifyAudioAvailableEvent OfflineAudioCompletionEvent OfflineAudioContext PannerNode ParentNode Performance PerformanceNavigation PerformanceTiming Plugin PluginArray Position PositionError PositionOptions PowerManager ProcessingInstruction ProgressEvent Promise PromiseResolver PushManager
	" syntax keyword javascriptWebAPI  Range ScriptProcessorNode Selection SettingsLock SettingsManager SharedWorker StyleSheet StyleSheetList SVGAElement SVGAngle SVGAnimateColorElement SVGAnimatedAngle SVGAnimatedBoolean SVGAnimatedEnumeration SVGAnimatedInteger SVGAnimatedLengthList SVGAnimatedNumber SVGAnimatedNumberList SVGAnimatedPoints SVGAnimatedPreserveAspectRatio SVGAnimatedRect SVGAnimatedString SVGAnimatedTransformList SVGAnimateElement SVGAnimateMotionElement SVGAnimateTransformElement SVGAnimationElement SVGCircleElement SVGClipPathElement SVGCursorElement SVGDefsElement SVGDescElement SVGElement SVGEllipseElement SVGFilterElement SVGFontElement SVGFontFaceElement SVGFontFaceFormatElement SVGFontFaceNameElement SVGFontFaceSrcElement SVGFontFaceUriElement
	" syntax keyword javascriptWebAPI  SVGForeignObjectElement SVGGElement SVGGlyphElement SVGGradientElement SVGHKernElement SVGImageElement SVGLength SVGLengthList SVGLinearGradientElement SVGLineElement SVGMaskElement SVGMatrix SVGMissingGlyphElement SVGMPathElement SVGNumber SVGNumberList SVGPathElement SVGPatternElement SVGPolygonElement SVGPolylineElement SVGPreserveAspectRatio SVGRadialGradientElement SVGRect SVGRectElement SVGScriptElement SVGSetElement SVGStopElement SVGStringList SVGStylable SVGStyleElement SVGSVGElement SVGSwitchElement SVGSymbolElement SVGTests SVGTextElement SVGTextPositioningElement SVGTitleElement SVGTransform SVGTransformable SVGTransformList SVGTRefElement SVGTSpanElement SVGUseElement SVGViewElement SVGVKernElement TCPSocket Telephony TelephonyCall Text TextDecoder TextEncoder TextMetrics TimeRanges Touch TouchEvent TouchList Transferable TransitionEvent TreeWalker TypeInfo UIEvent Uint16Array Uint32Array Uint8Array Uint8ClampedArray URL URLUtils URLUtilsReadOnly
	" }}}
	" DOM2 CONSTANT {{{
	syntax keyword javascriptDomErrNo       INDEX_SIZE_ERR DOMSTRING_SIZE_ERR HIERARCHY_REQUEST_ERR WRONG_DOCUMENT_ERR INVALID_CHARACTER_ERR NO_DATA_ALLOWED_ERR NO_MODIFICATION_ALLOWED_ERR NOT_FOUND_ERR NOT_SUPPORTED_ERR INUSE_ATTRIBUTE_ERR INVALID_STATE_ERR SYNTAX_ERR INVALID_MODIFICATION_ERR NAMESPACE_ERR INVALID_ACCESS_ERR
	syntax keyword javascriptDomNodeConsts  ELEMENT_NODE ATTRIBUTE_NODE TEXT_NODE CDATA_SECTION_NODE ENTITY_REFERENCE_NODE ENTITY_NODE PROCESSING_INSTRUCTION_NODE COMMENT_NODE DOCUMENT_NODE DOCUMENT_TYPE_NODE DOCUMENT_FRAGMENT_NODE NOTATION_NODE
	"}}}
	" HTML events and internal variables"{{{
	syntax case ignore
	syntax keyword javascriptHtmlEvents     onblur onclick oncontextmenu ondblclick onfocus onkeydown onkeypress onkeyup onmousedown onmousemove onmouseout onmouseover onmouseup onresize onload onsubmit
	syntax case match
	"}}}

	" Follow stuff should be highligh within a special context
	" While it can't be handled with context depended with Regex based highlight
	" So, turn it off by default
	if exists("javascript_enable_domhtmlcss")
	" DOM2 things {{{
	syntax match javascriptDomElemAttrs     contained /\%(nodeName\|nodeValue\|nodeType\|parentNode\|childNodes\|firstChild\|lastChild\|previousSibling\|nextSibling\|attributes\|ownerDocument\|namespaceURI\|prefix\|localName\|tagName\)\>/
	syntax match javascriptDomElemFuncs     contained /\%(insertBefore\|replaceChild\|removeChild\|appendChild\|hasChildNodes\|cloneNode\|normalize\|isSupported\|hasAttributes\|getAttribute\|setAttribute\|removeAttribute\|getAttributeNode\|setAttributeNode\|removeAttributeNode\|getElementsByTagName\|getAttributeNS\|setAttributeNS\|removeAttributeNS\|getAttributeNodeNS\|setAttributeNodeNS\|getElementsByTagNameNS\|hasAttribute\|hasAttributeNS\)\>/ nextgroup=javascriptParen skipwhite
	"}}}
	" HTML things {{{
	syntax match javascriptHtmlElemAttrs    contained /\%(className\|clientHeight\|clientLeft\|clientTop\|clientWidth\|dir\|id\|innerHTML\|lang\|length\|offsetHeight\|offsetLeft\|offsetParent\|offsetTop\|offsetWidth\|scrollHeight\|scrollLeft\|scrollTop\|scrollWidth\|style\|tabIndex\|title\)\>/
	syntax match javascriptHtmlElemFuncs    contained /\%(blur\|click\|focus\|scrollIntoView\|addEventListener\|dispatchEvent\|removeEventListener\|item\)\>/ nextgroup=javascriptParen skipwhite
	"}}}
	" CSS Styles in JavaScript {{{
	syntax keyword javascriptCssStyles      contained color font fontFamily fontSize fontSizeAdjust fontStretch fontStyle fontVariant fontWeight letterSpacing lineBreak lineHeight quotes rubyAlign rubyOverhang rubyPosition
	syntax keyword javascriptCssStyles      contained textAlign textAlignLast textAutospace textDecoration textIndent textJustify textJustifyTrim textKashidaSpace textOverflowW6 textShadow textTransform textUnderlinePosition
	syntax keyword javascriptCssStyles      contained unicodeBidi whiteSpace wordBreak wordSpacing wordWrap writingMode
	syntax keyword javascriptCssStyles      contained bottom height left position right top width zIndex
	syntax keyword javascriptCssStyles      contained border borderBottom borderLeft borderRight borderTop borderBottomColor borderLeftColor borderTopColor borderBottomStyle borderLeftStyle borderRightStyle borderTopStyle borderBottomWidth borderLeftWidth borderRightWidth borderTopWidth borderColor borderStyle borderWidth borderCollapse borderSpacing captionSide emptyCells tableLayout
	syntax keyword javascriptCssStyles      contained margin marginBottom marginLeft marginRight marginTop outline outlineColor outlineStyle outlineWidth padding paddingBottom paddingLeft paddingRight paddingTop
	syntax keyword javascriptCssStyles      contained listStyle listStyleImage listStylePosition listStyleType
	syntax keyword javascriptCssStyles      contained background backgroundAttachment backgroundColor backgroundImage gackgroundPosition backgroundPositionX backgroundPositionY backgroundRepeat
	syntax keyword javascriptCssStyles      contained clear clip clipBottom clipLeft clipRight clipTop content counterIncrement counterReset cssFloat cursor direction display filter layoutGrid layoutGridChar layoutGridLine layoutGridMode layoutGridType
	syntax keyword javascriptCssStyles      contained marks maxHeight maxWidth minHeight minWidth opacity MozOpacity overflow overflowX overflowY verticalAlign visibility zoom cssText
	syntax keyword javascriptCssStyles      contained scrollbar3dLightColor scrollbarArrowColor scrollbarBaseColor scrollbarDarkShadowColor scrollbarFaceColor scrollbarHighlightColor scrollbarShadowColor scrollbarTrackColor
	"}}}
	" Highlight ways {{{
	syntax match javascriptDotNotation      "\." nextgroup=javascriptPrototype,javascriptDomElemAttrs,javascriptDomElemFuncs,javascriptHtmlElemAttrs,javascriptHtmlElemFuncs
	syntax match javascriptDotNotation      "\.style\." nextgroup=javascriptCssStyles
	"}}}
	endif
" end DOM/HTML/CSS specified things }}}
" Code blocks"{{{
syntax cluster javascriptAll       contains=javascriptComment,javascriptLineComment,JSDocComment,javascriptString,javascriptRegexpString,javascriptNumber,javascriptFloat,javascriptLabel,javascriptSource,javascriptWebAPI,javascriptOperator,javascriptBoolean,javascriptNull,javascriptFuncKeyword,javascriptConditional,javascriptGlobal,javascriptRepeat,javascriptBranch,javascriptStatement,javascriptGlobalObjects,javascriptMessage,javascriptIdentifier,javascriptExceptions,javascriptReserved,javascriptDeprecated,javascriptDomErrNo,javascriptDomNodeConsts,javascriptHtmlEvents,javascriptDotNotation,javascriptBrowserObjects,javascriptDOMObjects,javascriptAjaxObjects,javascriptPropietaryObjects,javascriptDOMMethods,javascriptHtmlElemProperties,javascriptDOMProperties,javascriptEventListenerKeywords,javascriptEventListenerMethods,javascriptAjaxProperties,javascriptAjaxMethods,javascriptFuncArg

if main_syntax == "javascript"
	syntax sync clear
	syntax sync ccomment javascriptComment minlines=200
	" syntax sync match javascriptHighlight grouphere javascriptBlock /{/
endif
"}}}
" Function and arguments highlighting {{{
syntax keyword javascriptFuncKeyword     function contained
syntax region  javascriptFuncExp         start=/\w\+\s\==\s\=function\>/ end="\([^)]*\)" contains=javascriptFuncEq,javascriptFuncKeyword,javascriptFuncArg keepend
syntax match   javascriptFuncArg         "\(([^()]*)\)" contains=javascriptParens,javascriptFuncComma contained
syntax match   javascriptFuncComma       /,/ contained
syntax match   javascriptFuncEq          /=/ contained
syntax region  javascriptFuncDef         start="\<function\>" end="\([^)]*\)" contains=javascriptFuncKeyword,javascriptFuncArg keepend
"}}}
" Braces, Parens, symbols, colons {{{
syntax match javascriptBraces       "[{}\[\]]"
syntax match javascriptParens       "[()]"
syntax match javascriptOpSymbols    "=\{1,3}\|!==\|!=\|<\|>\|>=\|<=\|++\|+=\|--\|-="
syntax match javascriptEndColons    "[;,]"
syntax match javascriptLogicSymbols "\(&&\)\|\(||\)"
"}}}
" JavaScriptFold Function {{{

function! JavaScriptFold()
	setl foldmethod=syntax
	setl foldlevelstart=1
	syntax region foldBraces start=/{/ end=/}/ transparent fold keepend extend
endfunction

" }}}
" Highlight links {{{
" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_javascript_syn_inits")
	if version < 508
		let did_javascript_syn_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi def link <args>
	endif
	HiLink javascriptEndColons              Operator
	HiLink javascriptOpSymbols              Operator
	HiLink javascriptLogicSymbols           Boolean
	HiLink javascriptBraces                 Function
	HiLink javascriptParens                 Operator

	HiLink javascriptComment                Comment
	HiLink javascriptLineComment            Comment
	HiLink JSDocComment                     Comment
	HiLink javascriptCommentTodo            Todo

	HiLink JSDocTags                        Special
	HiLink JSDocSeeTag                      Function
	HiLink JSDocParam                       Function

	HiLink javascriptString                 String
	HiLink javascriptRegexpString           String

	HiLink javascriptNumber                 Number
	HiLink javascriptFloat                  Number

	HiLink javascriptGlobal                 Constant
	HiLink javascriptCharacter              Character
	HiLink javascriptPrototype              Type
	HiLink javascriptConditional            Conditional
	HiLink javascriptBranch                 Conditional
	HiLink javascriptIdentifier             Identifier
	HiLink javascriptRepeat                 Repeat
	HiLink javascriptStatement              Statement
	HiLink javascriptMessage                Keyword
	HiLink javascriptReserved               Keyword
	HiLink javascriptOperator               Operator
	HiLink javascriptNull                   Type
	HiLink javascriptBoolean                Boolean
	HiLink javascriptLabel                  Label
	HiLink javascriptSpecial                Special
	HiLink javascriptSource                 Special
	HiLink javascriptGlobalObjects          Special
	HiLink javascriptExceptions             Special

	HiLink javascriptDeprecated             Exception
	HiLink javascriptError                  Error
	HiLink javascriptParensError            Error
	HiLink javascriptParensErrA             Error
	HiLink javascriptParensErrB             Error
	HiLink javascriptParensErrC             Error
	HiLink javascriptDomErrNo               Error

	HiLink javascriptDomNodeConsts          Constant
	HiLink javascriptDomElemAttrs           Label
	HiLink javascriptDomElemFuncs           Type

	HiLink javascriptWebAPI                 Type

	HiLink javascriptHtmlElemAttrs          Label
	HiLink javascriptHtmlElemFuncs          Type

	HiLink javascriptCssStyles              Type

	HiLink javascriptBrowserObjects         Constant

	HiLink javascriptDOMObjects             Constant
	HiLink javascriptDOMMethods             Type
	HiLink javascriptDOMProperties          Label

	HiLink javascriptAjaxObjects            Constant
	HiLink javascriptAjaxMethods            Type
	HiLink javascriptAjaxProperties         Label

	HiLink javascriptFuncKeyword            Function
	HiLink javascriptFuncDef                PreProc
	HiLink javascriptFuncExp                Title
	HiLink javascriptFuncArg               	Special
	HiLink javascriptFuncComma              Operator
	HiLink javascriptFuncEq                 Operator

	HiLink javascriptHtmlEvents             Constant
	HiLink javascriptHtmlElemProperties     Label

	HiLink javascriptEventListenerKeywords  Type

	HiLink javascriptPropietaryObjects      Constant

	delcommand HiLink
endif
" end Highlight links }}}

" Define the htmlJavaScript for HTML syntax html.vim
"syntax clear htmlJavaScript
"syntax clear javascriptExpression
syntax cluster  htmlJavaScript contains=@javascriptAll,javascriptBracket,javascriptParen,javascriptBlock,javascriptParenError
syntax cluster  javascriptExpression contains=@javascriptAll,javascriptBracket,javascriptParen,javascriptBlock,javascriptParenError,@htmlPreproc

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
	unlet main_syntax
endif
syntax region jsInJsdocExample matchgroup=Snip start="^\s*\* @example" end="\(^\s*\* [^[:space:]]\)\@=" containedin=@javascriptComment contains=@javascriptAll
hi link Snip SpecialComment
