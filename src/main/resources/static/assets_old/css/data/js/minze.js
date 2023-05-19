!function(t){"function"==typeof define&&define.amd?define(t):t()}((function(){"use strict";const t=Symbol("isProxy");function e(t){return t.replace(/\B([A-Z])(?=[a-z])/g,"-$1").replace(/\B([a-z0-9])([A-Z])/g,"$1-$2").toLowerCase()}function i(t){return t.replace(/-([a-z])/g,(t=>t[1].toUpperCase()))}function n(t,...e){console.warn(`[Minze warn] ${t}`,...e)}class Minze{static define(t,e){customElements.define(t,e)}static defineAll(t){Array.isArray(t)||(t=Object.values(t)),t.forEach((t=>{const i=e(t.name);customElements.define(i,t)}))}static cast(t,e){dispatchEvent(new CustomEvent(t,{detail:e}))}static listen(t,e){addEventListener(t,e,!0)}static stopListen(t,e){removeEventListener(t,e,!0)}}function o(t,e,i,n){return new(i||(i=Promise))((function(o,s){function r(t){try{a(n.next(t))}catch(t){s(t)}}function l(t){try{a(n.throw(t))}catch(t){s(t)}}function a(t){var e;t.done?o(t.value):(e=t.value,e instanceof i?e:new i((function(t){t(e)}))).then(r,l)}a((n=n.apply(t,e||[])).next())}))}function s(t,e){const i="function"==typeof t?t():t,n=document.createElement("template");n.innerHTML=i,r(n,e),l(n,e)}function r(t,e){const i=t instanceof HTMLTemplateElement?t.content.childNodes:t.childNodes;i.length===e.childNodes.length?Array.from(i).forEach(((t,i)=>{const n=t,o=e.childNodes[i];n.isEqualNode(o)||(o.nodeType===Node.TEXT_NODE||o.nodeType===Node.COMMENT_NODE?o.textContent=n.textContent:o.nodeType===Node.ELEMENT_NODE&&r(n,o))})):e.textContent=t.textContent}function l(t,e){const i=t instanceof HTMLTemplateElement?t.content.children:t.children;i.length===e.children.length?Array.from(i).some(((t,i)=>{const n=t,o=e.children[i];if(!n.isEqualNode(o)){if(n.nodeName!==o.nodeName)return void o.replaceWith(n);Array.from(n.attributes).forEach((t=>{t.value!==o.getAttribute(t.name)&&o.setAttribute(t.name,t.value)})),Array.from(o.attributes).forEach((t=>{n.hasAttribute(t.name)||o.removeAttribute(t.name)})),l(n,o)}})):e.innerHTML=t.innerHTML}Minze.version="1.0.3";class MinzeElement extends HTMLElement{constructor(){super(),this.version="1.0.3",this.cachedTemplate=null,this.attachShadow({mode:"open"})}static get dashName(){return e(this.name)}static define(t){t||(t=e(this.name)),customElements&&customElements.define(t,this)}template(){var t,e,i,n;return`\n      <style>\n        :host { box-sizing: border-box; display: block; }\n        :host([hidden]) { display: none }\n        * { box-sizing: border-box; }\n        ${null!==(e=null===(t=this.css)||void 0===t?void 0:t.call(this))&&void 0!==e?e:""}\n      </style>\n      ${null!==(n=null===(i=this.html)||void 0===i?void 0:i.call(this))&&void 0!==n?n:"<slot></slot>"}\n    `}render(t){var e,i,n,r;return o(this,void 0,void 0,(function*(){if(this.shadowRoot){const l=this.template();if(l!==this.cachedTemplate||t){const a=this.cachedTemplate;this.cachedTemplate=l,yield null===(e=this.beforeRender)||void 0===e?void 0:e.call(this),null===(i=this.eventListeners)||void 0===i||i.forEach((t=>o(this,void 0,void 0,(function*(){return this.registerEvent(t,"remove")})))),!a||t?this.shadowRoot.innerHTML=l:s(l,this.shadowRoot),null===(n=this.eventListeners)||void 0===n||n.forEach((t=>o(this,void 0,void 0,(function*(){return this.registerEvent(t,"add")})))),null===(r=this.onRender)||void 0===r||r.call(this)}}}))}rerender(t){this.render(t)}select(t){var e;const i=this.shadowRoot;return null!==(e=null==i?void 0:i.querySelector(t))&&void 0!==e?e:null}selectAll(t){var e;const i=this.shadowRoot;return null!==(e=null==i?void 0:i.querySelectorAll(t))&&void 0!==e?e:null}exposeAttr(t,i){const n=e(t);this.setAttribute(n,"object"==typeof i?JSON.stringify(i):String(i))}reactiveChange(t,i,n,s,r,l,a){var c;return o(this,void 0,void 0,(function*(){const n=i,h=e(i);null===(c=this.watch)||void 0===c||c.forEach((([e,i])=>o(this,void 0,void 0,(function*(){(e===n||"attr"===t&&e===h)&&i(l,a,r,s)})))),this.render()}))}makeComplexReactive(e,i,n){const o=e,s=i;n&&this.exposeAttr(o,s);const r=()=>({get:(e,i)=>{if(i===t)return!0;let n=Reflect.get(e,i);return"object"!=typeof n||n[t]||(n=l(n),Reflect.set(e,i,n)),n},set:(t,e,i)=>{const r=Reflect.get(t,e);return r!==i&&(Reflect.set(t,e,i),n&&this.exposeAttr(o,s),this.reactiveChange("complex",o,s,t,e,i,r)),!0}}),l=t=>new Proxy(t,r());this[o]=l(s)}makePrimitiveReactive(t,e,i){const n=t,o=`$minze_stash_prop_${t}`;this[o]=e,i&&this.exposeAttr(t,e),Object.defineProperty(this,t,{get:()=>this[o],set:e=>{const s=this[o];s!==e&&(this[o]=e,i&&this.exposeAttr(t,e),this.reactiveChange("primitive",n,this[o],this,n,e,s))}})}registerProp(t){const e="string"==typeof t?t:t[0],i="string"==typeof t?null:t[1],o="string"==typeof t?void 0:t[2],s=e;s in this?n(`A property with the name "${s}" already exists in this component.`):i&&"object"==typeof i?this.makeComplexReactive(s,i,o):this.makePrimitiveReactive(s,i,o)}registerAttr(t){const e="string"==typeof t?t:t[0],o="string"==typeof t?null:t[1],s=i(e),r=e,l=s,a="object"==typeof o?JSON.stringify(o):String(o);if(s in this)return void n(`A property with the name "${s}" already exists.`);const c=`$minze_stash_attr_${s}`;this[c]=a,Array.isArray(t)&&2===t.length&&!this.getAttribute(r)&&this.setAttribute(r,a),Object.defineProperty(this,s,{get:()=>{const t=this.getAttribute(r);return"undefined"==t?void 0:"null"==t?null:(null==t?void 0:t.match(/^(true|false)$/))?JSON.parse(t):t},set:t=>{const e=this[c];e!==t&&(this[c]=t,this.reactiveChange("attr",l,this[c],this,l,t,e))}})}registerEvent(t,e){var i;const[n,o,s]=t;let r;n===window?r=[window]:n instanceof MinzeElement?r=[this]:"string"==typeof n&&(r=null===(i=this.shadowRoot)||void 0===i?void 0:i.querySelectorAll(n)),null==r||r.forEach((t=>{"add"===e?t.addEventListener(o,s,!0):t.removeEventListener(o,s,!0)}))}cast(t,e){this.dispatchEvent(new CustomEvent(t,{detail:e}))}connectedCallback(){var t,e,i,n,s,r,l;return o(this,void 0,void 0,(function*(){null===(t=this.onStart)||void 0===t||t.call(this),null===(e=this.reactive)||void 0===e||e.forEach((t=>o(this,void 0,void 0,(function*(){return this.registerProp(t)})))),null===(i=this.attrs)||void 0===i||i.forEach((t=>o(this,void 0,void 0,(function*(){return this.registerAttr(t)})))),null===(n=this.onReactive)||void 0===n||n.call(this),yield this.render(),(null===(r=null===(s=this.options)||void 0===s?void 0:s.exposeAttrs)||void 0===r?void 0:r.rendered)&&this.setAttribute("rendered",""),null===(l=this.onReady)||void 0===l||l.call(this)}))}disconnectedCallback(){var t,e;return o(this,void 0,void 0,(function*(){null===(t=this.eventListeners)||void 0===t||t.forEach((t=>o(this,void 0,void 0,(function*(){return this.registerEvent(t,"remove")})))),null===(e=this.onDestroy)||void 0===e||e.call(this)}))}adoptedCallback(){var t,e;return o(this,void 0,void 0,(function*(){null===(t=this.eventListeners)||void 0===t||t.forEach((t=>o(this,void 0,void 0,(function*(){return this.registerEvent(t,"remove")})))),null===(e=this.onMove)||void 0===e||e.call(this)}))}attributeChangedCallback(t,e,n){var s,r;return o(this,void 0,void 0,(function*(){yield null===(s=this.beforeAttributeChange)||void 0===s?void 0:s.call(this,t,e,n);const o=i(t);o in this&&n!==e&&(this[o]=n),null===(r=this.onAttributeChange)||void 0===r||r.call(this,t,e,n)}))}}window.Minze=Minze,window.MinzeElement=MinzeElement}));