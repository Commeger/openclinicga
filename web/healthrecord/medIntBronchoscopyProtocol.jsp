<%@page import="java.util.List"%>
<%@include file="/includes/validateUser.jsp"%>
<%@page errorPage="/includes/error.jsp"%>
<%=checkPermission(out,"occup.protocol.bronchoscopy","select",activeUser)%>

<%
	/// DEBUG /////////////////////////////////////////////////////////////////////////////////////
	if(Debug.enabled){
	    Debug.println("\n************** healthrecord/medIntBronchoscopyProtocol.jsp ************");
	    Debug.println("no parameters\n");
	}
	///////////////////////////////////////////////////////////////////////////////////////////////
%>

<form name="transactionForm" method="POST" action='<c:url value="/healthrecord/updateTransaction.do"/>?ts=<%=getTs()%>'>
	<bean:define id="transaction" name="be.mxs.webapp.wl.session.SessionContainerFactory.WO_SESSION_CONTAINER" property="currentTransactionVO"/>
	<%=checkPrestationToday(activePatient.personid,false,activeUser,(TransactionVO)transaction)%>
	
	<input type="hidden" id="transactionId" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.transactionId" value="<bean:write name="transaction" scope="page" property="transactionId"/>"/>
	<input type="hidden" id="serverId" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.serverId" value="<bean:write name="transaction" scope="page" property="serverId"/>"/>
	<input type="hidden" id="transactionType" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.transactionType" value="<bean:write name="transaction" scope="page" property="transactionType"/>"/>
	<input type="hidden" readonly name="be.mxs.healthrecord.updateTransaction.actionForwardKey" value="/main.do?Page=curative/index.jsp&ts=<%=getTs()%>"/>
	<input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_DEPARTMENT" property="itemId"/>]>.value" value="<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_DEPARTMENT" translate="false" property="value"/>"/>
	<input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_CONTEXT" translate="false" property="itemId"/>]>.value" value="<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_CONTEXT" translate="false" property="value"/>"/>
	
	<%=writeHistoryFunctions(((TransactionVO)transaction).getTransactionType(),sWebLanguage)%>
	<%=contextHeader(request,sWebLanguage)%>

	<%
	    String sPhysiologicalSerum = "";
	
	    if(transaction != null){
	        TransactionVO tran = (TransactionVO)transaction;
	        if(tran!=null){
	            sPhysiologicalSerum = getItemType(tran.getItems(),sPREFIX+"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PHYSIOLOGICAL_SERUM");
	        }
	    }
	%>

<table class="list" width="100%" cellspacing="1">
	<%-- DATE --%>
	<tr>
	    <td class="admin" width="<%=sTDAdminWidth%>">
	        <a href="javascript:openHistoryPopup();" title="<%=getTranNoLink("Web.Occup","History",sWebLanguage)%>">...</a>&nbsp;
	        <%=getTran(request,"Web.Occup", "medwan.common.date", sWebLanguage)%>
	    </td>
	    <td class="admin2">
	        <input type="text" class="text" size="12" maxLength="10" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.updateTime" value="<mxs:propertyAccessorI18N name="transaction" scope="page" property="updateTime" formatType="date"/>" id="trandate" OnBlur='checkDate(this)'>
	        <script>writeTranDate();</script>
	    </td>
	    <td class="admin" width="<%=sTDAdminWidth%>"/>
	    <td class="admin2"/>
	</tr>

	<%-- MOTIVE --%>
	<tr>
	    <td class="admin" width="<%=sTDAdminWidth%>"><%=getTran(request,"openclinic.chuk","motive",sWebLanguage)%></td>
	    <td class="admin2">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_MOTIVE" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_MOTIVE")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_MOTIVE" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_MOTIVE" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_MOTIVE_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	    <td class="admin" width="<%=sTDAdminWidth%>"><%=getTran(request,"openclinic.chuk","premedication",sWebLanguage)%></td>
	    <td class="admin2">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PREMEDICATION" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PREMEDICATION")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PREMEDICATION" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PREMEDICATION" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PREMEDICATION_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	</tr>

	<%-- ENDOSCOPY TYPE --%>
	<tr>
	    <td class="admin"><%=getTran(request,"openclinic.chuk", "endoscopy_type", sWebLanguage)%></td>
	    <td class="admin2">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_ENDOSCOPY_TYPE" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_ENDOSCOPY_TYPE")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_ENDOSCOPY_TYPE" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_ENDOSCOPY_TYPE" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_ENDOSCOPY_TYPE_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	    <td class="admin"><%=getTran(request,"openclinic.chuk", "pharynx_glottis", sWebLanguage)%></td>
	    <td class="admin2">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PHARYNX_GLOTTIS" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PHARYNX_GLOTTIS")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PHARYNX_GLOTTIS" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PHARYNX_GLOTTIS" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PHARYNX_GLOTTIS_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	</tr>

    <%-- TRACHEA --%>
	<tr>
	    <td class="admin"><%=getTran(request,"openclinic.chuk", "trachea", sWebLanguage)%></td>
	    <td class="admin2">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_TRACHEA" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_TRACHEA")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_TRACHEA" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_TRACHEA" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_TRACHEA_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	    <td class="admin"><%=getTran(request,"openclinic.chuk", "carène_principale", sWebLanguage)%></td>
	    <td class="admin2">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CARENE_PRINCIPALE" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CARENE_PRINCIPALE")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CARENE_PRINCIPALE" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CARENE_PRINCIPALE" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CARENE_PRINCIPALE_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	</tr>
	
	<%-- LEFT PRONCHITIS --%>
	<tr>
	    <td class="admin"><%=getTran(request,"openclinic.chuk", "left_bronchitis", sWebLanguage)%></td>
	    <td class="admin2">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_LEFT_BRONCHITIS" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_LEFT_BRONCHITIS")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_LEFT_BRONCHITIS" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_LEFT_BRONCHITIS" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_LEFT_BRONCHITIS_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	    <td class="admin"><%=getTran(request,"openclinic.chuk", "right_bronchitis", sWebLanguage)%></td>
	    <td class="admin2">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_RIGHT_BRONCHITIS" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_RIGHT_BRONCHITIS")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_RIGHT_BRONCHITIS" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_RIGHT_BRONCHITIS" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_RIGHT_BRONCHITIS_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	</tr>

	<%-- INVESTIGATIONS DONE --%>
	<tr>
		<td class="admin" style="vertical-align:top;padding-top:10px;"><%=getTran(request,"openclinic.chuk", "Investigations_done", sWebLanguage)%></td>
		<td style="vertical-align:top;">
			<table cellspacing="1" cellpadding="0" width="100%">
				<tr>
				    <td width="235" class="admin2">
				        <input <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_INHALATION")%> type="checkbox" id="inhalation" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_INHALATION" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_INHALATION;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="inhalation"><%=getTran(request,"openclinic.chuk", "inhalation", sWebLanguage)%></label>
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        <input onclick="doBroncho()" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BRONCHO_ALVELOLAIRE")%> type="checkbox" id="broncho_alvélolaire" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BRONCHO_ALVELOLAIRE" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BRONCHO_ALVELOLAIRE;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="broncho_alvélolaire"><%=getTran(request,"openclinic.chuk", "broncho_alvélolaire", sWebLanguage)%></label>
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        &nbsp;&nbsp;&nbsp;&nbsp;<input id="serum" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PHYSIOLOGICAL_SERUM")%> type="text" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PHYSIOLOGICAL_SERUM" property="itemId"/>]>.value" value="<%=sPhysiologicalSerum%>" size="4" onblur="isNumber(this); setBroncho()"/>&nbsp;cc&nbsp;&nbsp;<%=getTran(request,"openclinic.chuk", "physiological_serum", sWebLanguage)%> 
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        &nbsp;&nbsp;&nbsp;&nbsp;<input onclick="setBroncho()" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_ZIEHL_COLOR")%> type="checkbox" id="Ziehl_color" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_ZIEHL_COLOR" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_ZIEHL_COLOR;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="Ziehl_color"><%=getTran(request,"openclinic.chuk", "Ziehl_color", sWebLanguage)%></label>
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        &nbsp;&nbsp;&nbsp;&nbsp;<input onclick="setBroncho()" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_GRAM_COLOR")%> type="checkbox" id="gram_color" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_GRAM_COLOR" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_GRAM_COLOR;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="gram_color"><%=getTran(request,"openclinic.chuk", "gram_color", sWebLanguage)%></label>
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        &nbsp;&nbsp;&nbsp;&nbsp;<input onclick="setBroncho()" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BACTERIOLOGICAL_CULTURE")%> type="checkbox" id="bacteriological_culture" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BACTERIOLOGICAL_CULTURE" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BACTERIOLOGICAL_CULTURE;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="bacteriological_culture"><%=getTran(request,"openclinic.chuk", "bacteriological_culture", sWebLanguage)%></label>
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        &nbsp;&nbsp;&nbsp;&nbsp;<input onclick="setBroncho()" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BK_CULTURE")%> type="checkbox" id="BK_culture" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BK_CULTURE" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BK_CULTURE;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="BK_culture"><%=getTran(request,"openclinic.chuk", "BK_culture", sWebLanguage)%></label>
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        <input onclick="doBio()" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BIOPSIES_TRANSBRONCHITIS")%> type="checkbox" id="biopsies_transbronchitis" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BIOPSIES_TRANSBRONCHITIS" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_BIOPSIES_TRANSBRONCHITIS;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="biopsies_transbronchitis"><%=getTran(request,"openclinic.chuk", "biopsies_transbronchitis", sWebLanguage)%>
				    </label>
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        &nbsp;&nbsp;&nbsp;&nbsp;<input onclick="setBio()" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PERIPHERY")%> type="checkbox" id="periphery" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PERIPHERY" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PERIPHERY;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="periphery"><%=getTran(request,"openclinic.chuk", "peripheries", sWebLanguage)%></label>
				    </td>
				</tr>
				<tr>
				    <td class="admin2">
				        &nbsp;&nbsp;&nbsp;&nbsp;<input onclick="setBio()" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_PROTOCOL_CENTRAL")%> type="checkbox" id="central" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CENTRAL" property="itemId"/>]>.value" <mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CENTRAL;value=medwan.common.true" property="value" outputString="checked"/> value="medwan.common.true"/><label for="central"><%=getTran(request,"openclinic.chuk", "central", sWebLanguage)%></label>
				    </td>
				</tr>
			</table>
		</td>
		
		<%-- DIAGNOSES --%>
		<td class="admin2" colspan="2" rowspan="4" style="vertical-align:top;width:53%">
		    <%ScreenHelper.setIncludePage(customerInclude("healthrecord/diagnosesEncoding.jsp"),pageContext);%>
		</td>
	</tr>
    
    <%-- CONCLUSION --%>
	<tr>
	    <td class="admin" style="vertical-align:top;padding-top:10px;"><%=getTran(request,"openclinic.chuk","conclusion",sWebLanguage)%></td>
	    <td class="admin2" style="vertical-align:top;">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CONCLUSION" onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CONCLUSION")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CONCLUSION" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CONCLUSION" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_CONCLUSION_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	</tr>
	
    <%-- REMARKS --%>
	<tr>
	    <td class="admin" style="vertical-align:top;padding-top:10px;"><%=getTran(request,"openclinic.chuk","remarks",sWebLanguage)%></td>
	    <td class="admin2" style="vertical-align:top;">
	        <textarea id="ac_ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_REMARKS"onkeyup="resizeTextarea(this,10);limitChars(this,255);" <%=setRightClick(session,"ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_REMARKS")%> class="text" cols="60" rows="2" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_REMARKS" property="itemId"/>]>.value"><mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_REMARKS" property="value"/></textarea>
	        <div id="ITEM_TYPE_BRONCHOSCOPY_PROTOCOL_REMARKS_update" style="display:none;border:1px solid black;background-color:white;"></div>
	    </td>
	</tr>
</table>

	<%-- BUTTONS --%>
	<%=ScreenHelper.alignButtonsStart()%>
        <%=getButtonsHtml(request,activeUser,activePatient,"occup.protocol.bronchoscopy",sWebLanguage)%>
	<%=ScreenHelper.alignButtonsStop()%>

    <%=ScreenHelper.contextFooter(request)%>
</form>

<script>
  var itemsTypes = new Array();
  
  <%
      List itemsTypes = getItemTypeFromUser("ITEM_TYPE_BRONCHOSCOPY_PROTOCOL",Integer.parseInt(activeUser.userid));
      Iterator itemIter = itemsTypes.iterator();
      while(itemIter.hasNext()){
         out.write("\nitemsTypes.push('"+((String)itemIter.next()).substring(47)+"');");
      }
  %>

  itemsTypes.each(function(itemsTypes){
    autocompletionItems(itemsTypes);
  });

  function getAutocompletionValues(){
    itemsTypes.each(function(itemsTypes){
      if($('ac_'+itemsTypes)){
        var itemValues = Form.Element.Methods.getValue("ac_"+itemsTypes).replace(/^\s*|\s*$/g, '');
        if(itemValues!=""){
          testItemValue(itemsTypes, itemValues);
        }
      }
    });
  }

  function submitForm(){
    if(<%=((TransactionVO)transaction).getServerId()%>==1 && document.getElementById('encounteruid').value=='' <%=request.getParameter("nobuttons")==null?"":" && 1==0"%>){
      alertDialogDirectText('<%=getTranNoLink("web","no.encounter.linked",sWebLanguage)%>');
      searchEncounter();
  	}	
    else{
  	  document.getElementById("buttonsDiv").style.visibility = "hidden";
  	  var temp = Form.findFirstElement(transactionForm);// for ff compatibility
  	  document.transactionForm.submit();
    }
  }

  function searchEncounter(){
    openPopup("/_common/search/searchEncounter.jsp&ts=<%=getTs()%>&Varcode=encounteruid&VarText=&FindEncounterPatient=<%=activePatient.personid%>");
  }
  
  if(<%=((TransactionVO)transaction).getServerId()%>==1 && document.getElementById('encounteruid').value=='' <%=request.getParameter("nobuttons")==null?"":" && 1==0"%>){
	alertDialogDirectText('<%=getTranNoLink("web","no.encounter.linked",sWebLanguage)%>');
	searchEncounter();
  }	

  function doBroncho(){
    if(!document.getElementById("broncho_alvélolaire").checked){
      document.getElementById("serum").value = "";
      document.getElementById("Ziehl_color").checked = false;
      document.getElementById("gram_color").checked = false;
      document.getElementById("bacteriological_culture").checked = false;
      document.getElementById("BK_culture").checked = false;
    }
  }

  function setBroncho(){
    if(document.getElementById("serum").value.length > 0){
      document.getElementById("broncho_alvélolaire").checked = true;
    }
    else if(document.getElementById("Ziehl_color").checked){
      document.getElementById("broncho_alvélolaire").checked = true;
    }
    else if(document.getElementById("gram_color").checked){
      document.getElementById("broncho_alvélolaire").checked = true;
    }
    else if(document.getElementById("broncho_alvélolaire").checked){
      document.getElementById("broncho_alvélolaire").checked = true;
    }
    else if(document.getElementById("bacteriological_culture").checked){
      document.getElementById("broncho_alvélolaire").checked = true;
    }
    else if(document.getElementById("BK_culture").checked){
      document.getElementById("broncho_alvélolaire").checked = true;
    }
  }

  function doBio(){
    if(!document.getElementById("biopsies_transbronchitis").checked){
      document.getElementById("periphery").checked = false;
      document.getElementById("central").checked = false;
    }
  }

  function setBio(){
    if(document.getElementById("periphery").checked){
      document.getElementById("biopsies_transbronchitis").checked = true;
    }
    else if(document.getElementById("central").checked){
      document.getElementById("biopsies_transbronchitis").checked = true;
    }
  }
</script>