<%@ page import="grailsdemo.Country" %>



<div class="fieldcontain ${hasErrors(bean: countryInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="country.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="100" required="" value="${countryInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: countryInstance, field: 'iso2digitCode', 'error')} required">
	<label for="iso2digitCode">
		<g:message code="country.iso2digitCode.label" default="Iso2digit Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="iso2digitCode" maxlength="2" required="" value="${countryInstance?.iso2digitCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: countryInstance, field: 'iso3digitCode', 'error')} required">
	<label for="iso3digitCode">
		<g:message code="country.iso3digitCode.label" default="Iso3digit Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="iso3digitCode" maxlength="3" required="" value="${countryInstance?.iso3digitCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: countryInstance, field: 'cities', 'error')} ">
	<label for="cities">
		<g:message code="country.cities.label" default="Cities" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${countryInstance?.cities?}" var="c">
    <li><g:link controller="city" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="city" action="create" params="['country.id': countryInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'city.label', default: 'City')])}</g:link>
</li>
</ul>

</div>

