<%@ page import="grailsdemo.City" %>



<div class="fieldcontain ${hasErrors(bean: cityInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="city.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" maxlength="100" required="" value="${cityInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cityInstance, field: 'country', 'error')} required">
	<label for="country">
		<g:message code="city.country.label" default="Country" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="country" name="country.id" from="${grailsdemo.Country.list()}" optionKey="id" required="" value="${cityInstance?.country?.id}" class="many-to-one"/>
</div>

