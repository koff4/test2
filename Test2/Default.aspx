
<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Test1._Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="Content/Site.css">
    
        <script type="text/javascript">
            var pv = 0;
        function dialogDeleteConfirm()
        {
            //Почему то срабатывает по Enter на форме редактирования
            //alert(pv);
            if (pv == 1) return false;
        return (confirm("Удалить товар???"));
        }

        function Hidepopup() {
            $find("popup").hide();
            pv=0;
            return false;
        }
        function Showpopup() {
            $find("popup").show();
            pv=1;
            return false;
        }

        function NewFormData(sid) {
            //confirm("888");
         
            document.getElementById("PopupHeader2").innerHTML = "Добавить товар";
            //confirm("???")
            //$find("popup").show();
            Showpopup();
            document.getElementById("MainContent_txtName").focus();
            document.getElementById("MainContent_txtName").value = "";
            document.getElementById("MainContent_txtPrice").value = "0,00";
            document.getElementById("MainContent_goodID").value = sid;
            //confirm("!!!")
            return true;
        }
        function EditFormData(sid, sName, sPrice) {
            //confirm("555");
            //$find("PopupHeader"); //.Text = "Добавить товар";
            document.getElementById("PopupHeader2").innerHTML = "Изменить товар";
            //confirm("???")
            //$find("popup").show();
            Showpopup();
            document.getElementById("MainContent_txtName").focus();
            document.getElementById("MainContent_txtName").value = sName;
            document.getElementById("MainContent_txtPrice").value = sPrice;
            document.getElementById("MainContent_goodID").value = sid;
            //confirm("!!!")
            return true;
        }

        function ValidateForm(h) {
            var sName,sPrice;
            var sElem;
            sName=document.getElementById("MainContent_txtName").value;
            sElem = document.getElementById("MainContent_txtName");
            sPrice = document.getElementById("MainContent_txtPrice").value;
            
            //alert("PRICE0 " + sPrice + " SNAME0 " + sName + " sElem " + sElem.innerHTML + " .. " + document.getElementById("MainContent_txtName").value);
            if (sName == '') { 
                alert("Не указано наименование"); 
                if (h == true) { Hidepopup(); } 
                return false; 
            }
            //, -> .
            //alert(sPrice.replace(",", "."));
            if (!$.isNumeric(sPrice.replace(",", "."))) {
                alert("Неправильно введена цена"); if (h == true) { Hidepopup(); } return false;
            }
                if (h == true) Hidepopup();
            return true;
        }
        </script>

    <div class="jumbotron">
        <h1>Товары</h1>
    </div>

    <div class="row">
        <div class="col-md-4">
             <p>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>         
                <asp:Button ID="ButtonInsert" runat="server" Text="Добавить(Add)" CommandName="Insert" CommandArgument="New" OnCommand="ButtonInsert_Command" OnClientClick="NewFormData('0');" UseSubmitBehavior="False" />  
                 

                <%--<a class="btn btn-default" href="http://go.microsoft.com/fwlink/?LinkId=301948">Learn more &raquo;</a>--%>
                 
                 <asp:ListView ID="ListView2" runat="server" DataKeyNames="GoodID" DataSourceID="SqlDS" onitemdatabound="l_ItemDataBound" >
                     
                     <EmptyDataTemplate>
                         <table runat="server" style="">
                             <tr>
                                 <td>No data was returned.</td>
                             </tr>
                         </table>
                     </EmptyDataTemplate>
                     <ItemTemplate>
                         <tr style="" >
                             <td width="10%" align="right">
                                 <%# Eval("GoodID") %>
                                 <%--<asp:DynamicControl runat="server" DataField="GoodID" Mode="ReadOnly" />--%>
                             </td>
                             <td  width="60%"><%# Eval("Name") %>
                                 <%--<asp:DynamicControl runat="server" DataField="Name" Mode="ReadOnly" />--%>
                             </td>
                             <td align="right">
                                 <%# Eval("Price") %>
                                 <%--<asp:DynamicControl runat="server" DataField="Price" Mode="ReadOnly" />--%>
                             </td>
                             <td width="40%">
                                 <%--<asp:Button ID="ButtonModify" runat="server" Text='<%# "return EditFormData(" + Eval("Name") + " Name" + " Price" + ")" %>' OnClientClick='<%"return EditFormData(" + Eval("Name") + "Name" +"Price" + ")"%>' CommandName="Modify" CommandArgument='<%#Eval("GoodID")  %>' OnCommand="ButtonModify_Command"/>--%>
                                 <%-- asp:Button ID="ButtonModify" runat="server" Text="Изменить" OnClientClick="return EditFormData('<%#Eval("GoodID")  %>', '<%#Eval("Name")  %>', '<%#Eval("Price")  %>')" CommandName="Modify" CommandArgument='<%#Eval("GoodID")  %>' OnCommand="ButtonModify_Command"/>--%>
                                 <%--Попробуем вынести OnClientClick в событие--%>
                                 <asp:Button ID="ButtonModify" runat="server" Text="Изменить" OnClientClick='return true' CommandName="Modify" CommandArgument='<%#Eval("GoodID")  %>' OnCommand="ButtonModify_Command" UseSubmitBehavior="False"/>
                                 <asp:Button ID="ButtonDelete" runat="server" Text="Удалить" OnClientClick="return dialogDeleteConfirm();"  CommandName="Delete" CommandArgument='<%#Eval("GoodID")  %>' OnCommand="ButtonDelete33_Command" UseSubmitBehavior="True"/>

                                 <%--<a class="btn btn-default" href="delete.aspx">Удалить</a>--%>
                             </td>

                         </tr>
                     </ItemTemplate>
                     <LayoutTemplate>
                         <table runat="server"  Width="900px" border="0" cellpadding="4">
                             <tr runat="server">
                                 <td runat="server">
                                     <table id="itemPlaceholderContainer" runat="server" border="1" style="">
                                         <tr runat="server" style="">
                                             <th runat="server"  >ID</th>
                                             <th runat="server" >Наименование</th>
                                             <th runat="server" >Цена(руб)</th>
                                             <th runat="server" > </th>
                                         </tr>
                                         <tr id="itemPlaceholder" runat="server">
                                         </tr>
                                     </table>
                                 </td>
                             </tr>
                             <tr runat="server">
                                 <td runat="server" style="">
                                     <asp:DataPager ID="DataPager1" PageSize="2" runat="server">
                                         <Fields>
                                             <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" ShowLastPageButton="False" />
                                             <asp:NumericPagerField />
                                             <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" />
                                         </Fields>
                                     </asp:DataPager>
                                 </td>
                             </tr>
                         </table>
                     </LayoutTemplate>
                 </asp:ListView>
              </ContentTemplate>
            </asp:UpdatePanel>
                 <asp:SqlDataSource ID="SqlDS" runat="server" ConnectionString="<%$ ConnectionStrings:GoodContext %>" SelectCommand="SELECT GoodID, Name, Price FROM Goods" 
                      DeleteCommand="DELETE FROM goods where goods.GoodID = @GoodID">
                     <DeleteParameters>
                         <asp:Parameter DbType="Int32" Name="GoodID" />
                     </DeleteParameters>
                 </asp:SqlDataSource>
                
                 
            </p>
             
        </div>
        
    </div>
    
<asp:button id="Button1" runat="server" text="Button" style="display: none" />

    <asp:LinqDataSource ID="LinqDataSource2" runat="server" ContextTypeName="LINQData"></asp:LinqDataSource>

    <ajaxToolkit:modalpopupextender id="popup" BehaviorID="popup" runat="server"
        cancelcontrolid="btnCancel" 
        popupcontrolid="pnlAddEdit" TargetControlID="Button1"
        popupdraghandlecontrolid="PopupHeader" drag="true"
        backgroundcssclass="ModalPopupBG">
    </ajaxToolkit:modalpopupextender>
	

<asp:panel id="Panel1" CssClass="modalPopup" style="display: none" runat="server" BorderStyle="Solid" BackColor="White" Width ="300px">
	<div class="HellowWorldPopup">
                <div class="PopupHeader" id="PopupHeader1">Header</div>
                <div class="PopupBody">
                    <p>This is a simple modal dialog</p>
                </div>
                <div class="Controls">
                    <input id="btnOkay1" type="button" value="Done" />
                    <input id="btnCancel1" type="button" value="Cancel" />
		</div>
        </div>
</asp:panel>

<asp:Panel ID="pnlAddEdit" runat="server" CssClass="modalPopup" style = "display:none" Width ="400px">
<div id="PopupHeader2" style="font-weight:bold;">Товар</div>
    <asp:HiddenField ID="goodID" runat="server" Value="None" />
<%-- asp:Label Font-Bold = "true" ID="PopupHeader" BehaviorID="PopupHeader" runat = "server" Text = "Товар" ></asp:Label> 
<br />--%>
<table align = "center">
<tr>
<td>
<asp:Label ID = "Label1" runat = "server" Text = "Наименование" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtName" Width = "200px" MaxLength = "40" runat="server"></asp:TextBox>



<tr>
<td>
<asp:Label ID = "Label2" runat = "server" Text = "Цена" ></asp:Label>
</td>
<td>
<asp:TextBox ID="txtPrice" Width = "100px" MaxLength = "10" runat="server"></asp:TextBox>
 <%--  <ajaxToolkit:MaskedEditExtender
    TargetControlID="txtPrice" 
    Mask="9,999,999.99"
    MessageValidatorTip="true" 
    MaskType="Number" 
    InputDirection="LeftToRight" 
    AcceptNegative="Left"
    ErrorTooltipEnabled="True"
     runat="server" />--%>
</td>
</tr>
<tr>
<td>
<asp:Button ID="btnSave" runat="server" Text="Сохранить" OnClientClick = "return ValidateForm(true)" OnCommand = "Save" CommandName ="Insert" />
</td>
<td>
<asp:Button ID="btnCancel" runat="server" Text="Отменить" OnClientClick = "return Hidepopup()"/>
</td>
</tr>
</table>
</asp:Panel>
</asp:Content>
