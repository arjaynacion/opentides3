<%@ page contentType="text/html;utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tides" uri="http://www.ideyatech.com/tides"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>

<app:header pageTitle="label.widget" active="widget">
	<script type="text/javascript" src="<c:url value='/js/jquery-ui.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.iframe-transport.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.fileupload.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.fileupload-process.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/jquery.fileupload-image.js'/>"></script>
</app:header>

<div id="widget-body">

<ul class="breadcrumb">
  <li><a href="${home}/"><spring:message code="label.home"/></a> <span class="divider">/</span></li>
  <li><spring:message code="label.widget"/></li>
</ul>

<div id="search-body">

	<div id="search-panel" class="span3">

		<div id="search-panel-inner" data-spy="affix" data-offset-top="60">
			<div class="navbar">
				<div class="navbar-inner">
					<span class="brand"><i class="icon-search"></i><spring:message code="label.search" /></span>
					<a class="show-search-form btn collapsed pull-right hidden-desktop hidden-tablet" data-toggle="collapse" data-target=".search-form">
						<i class="icon-chevron-up"></i>
						<i class="icon-chevron-down"></i>
					</a>
				</div>
			</div>
			<div class="search-form collapse">
				<form:form modelAttribute="searchCommand" id="widget-search" >
					<tides:input path="name" label="label.widget.name" cssClass="input-block-level"/>
					<tides:input path="title" label="label.widget.title" cssClass="input-block-level"/>
					<tides:input path="url" label="label.widget.url" cssClass="input-block-level"/>
					<tides:input path="accessCode" label="label.widget.accessCode" cssClass="input-block-level"/>
					<hr/>
					<input type="submit" class="btn btn-info btn-block" data-submit="search" value="<spring:message code="label.search"/>">
					<button type="button" class="btn btn-link btn-block" data-submit="clear"><spring:message code="label.clear" /></button>
				</form:form>
			</div>
		</div>
	</div>
	
	<div id="results-panel" class="span9">
		
		<div id="message-panel" class="row-fluid">
			<button id="widget-add" class="btn btn-info add-action">
				<i class="icon-plus-sign icon-white"></i>
				<spring:message code="label.widget.add" />
			</button>
			<div class="status" data-display-pagelinks="false" data-display-summary="true" data-summary-message='
				<spring:message code="message.displaying-x-of-y" arguments="#start,#end,#total,records"/>
			'>
				<tides:status results="${results}" />
			</div>
		</div>
		
		<div class="clear"></div>
		
		<div class="table-wrapper-2 overflow-hidden">
			<div class="table-wrapper">
				<table id="widget-results" class="footable table-bordered table-striped table-hover table-condensed" data-page="${results.currPage}" >
					<thead>
						<tr class="table-header">
							<th data-field-name="name"><spring:message code="label.widget.name" /></th>
							<th data-field-name="title"><spring:message code="label.widget.title" /></th>
							<th data-field-name="isShown"><spring:message code="label.widget.isShown" /></th>
							<th data-field-name="lastCacheUpdate"><spring:message code="label.widget.lastCacheUpdate" /></th>
							<th data-field-name="ot3-controls"></th>
						</tr>
					</thead>
					<tbody>
						<script type="text/template" class="template">
	                		<tr data-id="{{id}}">
								<td>{{name}}</td>
								<td>{{title}}</td>
								<td>{{isShown}}</td>
								<td>{{lastCacheUpdate}}</td>
								<td>
									<i class='icon-pencil edit-action' data-id='{{id}}' data-title="<spring:message code="label.edit" />"></i>
									<i class='icon-trash remove-action' data-id='{{id}}' data-title="<spring:message code="label.delete" />"></i>
								</td>
							</tr>
						</script>
						<c:forEach items="${results.results}" var="record" varStatus="status">
							<tr id="widget-row-${record.id}">
								<td><c:out value="${record.name}" /></td>
								<td><c:out value="${record.title}" /></td>
								<td><c:out value="${record.isShown}" /></td>
								<td><c:out value="${record.lastCacheUpdate}" /></td>
								<td>
									<i class='icon-pencil edit-action' data-id='${record.id}' data-title="<spring:message code="label.edit" />"></i>
									<i class='icon-trash remove-action' data-id='${record.id}' data-title="<spring:message code="label.delete" />"></i>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>	
			</div>
		</div>

		<div class="paging clearfix">
			<tides:paging results="${results}"/>
		</div>
	</div>
	
</div>

<div id="form-body" class="modal fade hide">

	<div id="form-panel" >
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">&times;</button>
			<h4 class="${add}"><spring:message code="label.widget.add" /></h4>
			<h4 class="${update}"><spring:message code="label.widget.update" /></h4>
		</div>

		<form:form modelAttribute="formCommand" id="widget-form" cssClass="form-horizontal">
			<div class="modal-body">
				<div class="message-container"></div>
				<tides:input path="name" label="label.widget.name" required="true"/>
				<tides:input path="title" label="label.widget.title" required="true"/>
				<tides:checkbox path="isShown" label="label.widget.isShown" />
				<tides:input path="description" label="label.widget.description" />
				<tides:input path="url" label="label.widget.url" required="true"/>
				<tides:input path="accessCode" label="label.widget.accessCode" />
				<tides:input path="cacheDuration" label="label.widget.cacheDuration" />
				<tides:input_file label="label.widget.screenshot" 
					dropZone="false" id="screenshot"/>
				<tides:input path="lastCacheUpdate" label="label.widget.lastCacheUpdate" />
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-link" data-dismiss="modal"><spring:message code="label.close" /></button>
				<input type="submit" class="btn btn-info  ${add}" data-form-display="add" data-submit="save-and-new" value="<spring:message code="label.save-and-new" />" />
				<input type="submit" class="btn btn-success" data-submit="save" value="<spring:message code="label.save" />" />
				<input type="hidden" name="id" />
			</div>
		</form:form>
	</div>
	
</div>

</div>

<tides:footer>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#widget-body").RESTful();
			$('body').tooltip({selector: '.edit-action, .remove-action'});
		});
	</script>
</tides:footer>