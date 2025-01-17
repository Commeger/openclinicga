<%@page import="java.io.*,org.apache.commons.io.*"%>
<%@page import="be.openclinic.archiving.ArchiveDocument,be.openclinic.system.*"%>
<%@page errorPage="/includes/error.jsp"%>
<%@include file="/includes/validateUser.jsp"%>


<%
    String sDocumentId = "";

    String sUDI="";
    
    Hashtable hParameters = SH.getMultipartFormParameters(request);
    String sAssetUID = (String)hParameters.get("assetuid");
    String sDocumentName = (String)hParameters.get("name");
    String sUrl = (String)hParameters.get("url");
    String sMaintenancePlanUid = (String)hParameters.get("maintenanceplanuid");
    FormFile formFile = (FormFile)hParameters.get("filename");
    if(formFile!=null){
        try{
            if(formFile!=null){
        	    String sFileName = formFile.getFilename();
                if(formFile.isAcceptableUploadFileExtension()){
                	%>
                	<script>
                		alert("<%=getTranNoLink("web","forbiddenfiletype",sWebLanguage)%>");
                		window.close();
                	</script>
                	<%
                }
                else if(sAssetUID.length()>0){
	                if(sFileName.trim().length()>0){
		                //We cre�ren een nieuw archiving document
		             	String sSql = "INSERT INTO arch_documents (arch_document_serverid, arch_document_objectid, arch_document_udi,"+
		              	"  arch_document_title, arch_document_category,arch_document_date, arch_document_reference,"+
			  	        "  arch_document_updatetime, arch_document_updateid,arch_document_tran_serverid)"+
		                " VALUES (?,?,?,?,?,?,?,?,?,-1)";		
		                Connection conn=MedwanQuery.getInstance().getOpenclinicConnection();
		                PreparedStatement ps = conn.prepareStatement(sSql);
		                ps.setInt(1,MedwanQuery.getInstance().getConfigInt("serverId",1));
		                int objectId=MedwanQuery.getInstance().getOpenclinicCounter("ARCH_DOCUMENTS",-100000);
		                if(objectId<0){
		                	sUDI="-"+ArchiveDocument.generateUDI(-objectId);
		                }
		                else{
		                	sUDI=ArchiveDocument.generateUDI(objectId);
		                }
		                ps.setInt(2,objectId);
		                ps.setString(3,sUDI);
		                ps.setString(4,sDocumentName);
		                ps.setString(5,"asset");
		                ps.setTimestamp(6, new Timestamp(new java.util.Date().getTime()));
		                ps.setString(7,"asset."+sAssetUID);
		                ps.setTimestamp(8, new Timestamp(new java.util.Date().getTime()));
						ps.setString(9,activeUser.userid);
						ps.execute();
						ps.close();
						conn.close();
						String sUid=sUDI+"."+FilenameUtils.getExtension(sFileName);
						formFile.store(SH.getScanDirectoryFromPath()+"/"+sUid);
	                }
	                else{
		                //We cre�ren een nieuw archiving document
		             	String sSql = "INSERT INTO arch_documents (arch_document_serverid, arch_document_objectid, arch_document_udi,"+
		              	"  arch_document_title, arch_document_category,arch_document_date, arch_document_reference, arch_document_storagename,"+
			  	        "  arch_document_updatetime, arch_document_updateid)"+
		                " VALUES (?,?,?,?,?,?,?,?,?,?)";		
		                Connection conn=MedwanQuery.getInstance().getOpenclinicConnection();
		                PreparedStatement ps = conn.prepareStatement(sSql);
		                ps.setInt(1,MedwanQuery.getInstance().getConfigInt("serverId",1));
		                int objectId=MedwanQuery.getInstance().getOpenclinicCounter("ARCH_DOCUMENTS",-100000);
		                if(objectId<0){
		                	sUDI="-"+ArchiveDocument.generateUDI(-objectId);
		                }
		                else{
		                	sUDI=ArchiveDocument.generateUDI(objectId);
		                }
						ps.setInt(2,objectId);
		                ps.setString(3,sUDI);
		                ps.setString(4,sDocumentName);
		                ps.setString(5,"asset");
		                ps.setTimestamp(6, new Timestamp(new java.util.Date().getTime()));
		                ps.setString(7,"asset."+sAssetUID);
		                ps.setString(8,sUrl);
		                ps.setTimestamp(9, new Timestamp(new java.util.Date().getTime()));
						ps.setString(10,activeUser.userid);
						ps.execute();
						ps.close();
						conn.close();
	                }
            	}
            	else if(sMaintenancePlanUid.length()>0){
	                if(sFileName.trim().length()>0){
		                //We cre�ren een nieuw archiving document
		             	String sSql = "INSERT INTO arch_documents (arch_document_serverid, arch_document_objectid, arch_document_udi,"+
		              	"  arch_document_title, arch_document_category,arch_document_date, arch_document_reference,"+
			  	        "  arch_document_updatetime, arch_document_updateid,arch_document_tran_serverid)"+
		                " VALUES (?,?,?,?,?,?,?,?,?,-1)";		
		                Connection conn=MedwanQuery.getInstance().getOpenclinicConnection();
		                PreparedStatement ps = conn.prepareStatement(sSql);
		                ps.setInt(1,MedwanQuery.getInstance().getConfigInt("serverId",1));
		                int objectId=MedwanQuery.getInstance().getOpenclinicCounter("ARCH_DOCUMENTS",-100000);
		                if(objectId<0){
		                	sUDI="-"+ArchiveDocument.generateUDI(-objectId);
		                }
		                else{
		                	sUDI=ArchiveDocument.generateUDI(objectId);
		                }
		                ps.setInt(2,objectId);
		                ps.setString(3,sUDI);
		                ps.setString(4,sDocumentName);
		                ps.setString(5,"maintenanceplan");
		                ps.setTimestamp(6, new Timestamp(new java.util.Date().getTime()));
		                ps.setString(7,"maintenanceplan."+sMaintenancePlanUid);
		                ps.setTimestamp(8, new Timestamp(new java.util.Date().getTime()));
						ps.setString(9,activeUser.userid);
						ps.execute();
						ps.close();
						conn.close();
						String sUid=sUDI+"."+FilenameUtils.getExtension(sFileName);
						formFile.store(SH.getScanDirectoryFromPath()+"/"+sUid);
	                }
	                else {
		                //We cre�ren een nieuw archiving document
		             	String sSql = "INSERT INTO arch_documents (arch_document_serverid, arch_document_objectid, arch_document_udi,"+
		              	"  arch_document_title, arch_document_category,arch_document_date, arch_document_reference, arch_document_storagename,"+
			  	        "  arch_document_updatetime, arch_document_updateid)"+
		                " VALUES (?,?,?,?,?,?,?,?,?,?)";		
		                Connection conn=MedwanQuery.getInstance().getOpenclinicConnection();
		                PreparedStatement ps = conn.prepareStatement(sSql);
		                ps.setInt(1,MedwanQuery.getInstance().getConfigInt("serverId",1));
		                int objectId=MedwanQuery.getInstance().getOpenclinicCounter("ARCH_DOCUMENTS",-100000);
		                if(objectId<0){
		                	sUDI="-"+ArchiveDocument.generateUDI(-objectId);
		                }
		                else{
		                	sUDI=ArchiveDocument.generateUDI(objectId);
		                }
		                ps.setInt(2,objectId);
		                ps.setString(3,sUDI);
		                ps.setString(4,sDocumentName);
		                ps.setString(5,"maintenanceplan");
		                ps.setTimestamp(6, new Timestamp(new java.util.Date().getTime()));
		                ps.setString(7,"maintenanceplan."+sMaintenancePlanUid);
		                ps.setString(8,sUrl);
		                ps.setTimestamp(9, new Timestamp(new java.util.Date().getTime()));
						ps.setString(10,activeUser.userid);
						ps.execute();
						ps.close();
						conn.close();
	                }
            	}
            }
        }
        catch(Exception e){
        	Debug.printStackTrace(e);
        }
        out.println("<script>if(window.opener.monitordocuments){window.opener.monitordocuments('"+sUDI+"')};window.close();</script>");
    }
    else{
    	if(checkString(request.getParameter("assetuid")).length()>0){
    		sAssetUID=checkString(request.getParameter("assetuid"));
    	}
    	else if(checkString(request.getParameter("maintenanceplanuid")).length()>0){
    		sAssetUID=checkString(request.getParameter("maintenanceplanuid"));
    	}
    }
%>

<form name='transactionForm' method='post' enctype='multipart/form-data'>
	<%
		if(checkString(request.getParameter("assetuid")).length()>0){
	%>
			<input type='hidden' name='assetuid' id='assetuid' value='<%=sAssetUID %>'/>
	<%
		}
		else if(checkString(request.getParameter("maintenanceplanuid")).length()>0){
	%>		
			<input type='hidden' name='maintenanceplanuid' id='maintenanceplanuid' value='<%=sAssetUID %>'/>
	<%
		}
	%>
			
	<table width='100%'>
		<tr class='admin'>
			<td colspan='2'><%=getTran(request,"web","uploaddocument",sWebLanguage) %></td>
		</tr>
		<tr>
			<td class='admin'><%=getTran(request,"web","name",sWebLanguage) %></td>
			<td class='admin2'><input type='text' class='text' name='name' id='name' value='' size='60'/></td>
		</tr>
		<tr>
			<td class='admin'><%=getTran(request,"web","file",sWebLanguage) %></td>
			<td class='admin2'><input type='file' class='text' name='filename' id=fileupload/></td>
		</tr>
		<tr>
			<td class='admin'><%=getTran(request,"web","url",sWebLanguage) %></td>
			<td class='admin2'><input type='text' class='text' name='url' id='url' value='' size='60' onkeyup='document.getElementById("submitButton").style.visibility="visible";' onblur='checkURL();'/></td>
		</tr>
		<tr>
			<td class='admin'/>
			<td class='admin2'><input type='submit' class='button' id='submitButton' name='submit' value='<%=getTranNoLink("web","upload",sWebLanguage)%>'/></td>
		</tr>
	</table>
</form>

<script>
	function checkURL(){
		if(document.getElementById('url').value.length>0 && !(document.getElementById('url').value.startsWith('http')||document.getElementById('url').value.startsWith('ftp'))){
			alert('<%=getTranNoLink("web","URLmustStartWithHtppOrFTP",sWebLanguage)%>');
			document.getElementById('submitButton').style.visibility="hidden";
		}
	}
</script>