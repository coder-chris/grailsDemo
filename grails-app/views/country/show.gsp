
<%@ page import="grailsdemo.Country" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'country.label', default: 'Country')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-country" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-country" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list country">
			
				<g:if test="${countryInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="country.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${countryInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${countryInstance?.iso2digitCode}">
				<li class="fieldcontain">
					<span id="iso2digitCode-label" class="property-label"><g:message code="country.iso2digitCode.label" default="Iso2digit Code" /></span>
					
						<span class="property-value" aria-labelledby="iso2digitCode-label"><g:fieldValue bean="${countryInstance}" field="iso2digitCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${countryInstance?.iso3digitCode}">
				<li class="fieldcontain">
					<span id="iso3digitCode-label" class="property-label"><g:message code="country.iso3digitCode.label" default="Iso3digit Code" /></span>
					
						<span class="property-value" aria-labelledby="iso3digitCode-label"><g:fieldValue bean="${countryInstance}" field="iso3digitCode"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${countryInstance?.cities}">
				<li class="fieldcontain">
					<span id="cities-label" class="property-label"><g:message code="country.cities.label" default="Cities" /></span>
					
						<g:each in="${countryInstance.cities}" var="c">
						<span class="property-value" aria-labelledby="cities-label"><g:link controller="city" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${countryInstance?.id}" />
					<g:link class="edit" action="edit" id="${countryInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
