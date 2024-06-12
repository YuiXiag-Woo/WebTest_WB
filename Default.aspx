<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebTest_WB._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <div>

<asp:Label ID="Label1" runat="server" Text="姓名"></asp:Label>
               <asp:TextBox ID="NameTB" runat="server"></asp:TextBox>
               <br />
     <asp:Label ID="Label2" runat="server" Text="年齡"></asp:Label>
               <asp:TextBox ID="AgeTB" runat="server"></asp:TextBox>
               <br />
     <asp:Label ID="Label3" runat="server" Text="生日"></asp:Label>

               <asp:TextBox ID="BirthTB" runat="server"></asp:TextBox>
               <br />
               <asp:Button ID="CreateBtn" runat="server" Text="新建帳號" OnClick="CreateBtn_Click" Width="110px" />

               <asp:Button ID="EditBtn" runat="server" Text="修改帳號" OnClick="EditBtn_Click" Visible="False" Width="110px" />

               <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="#DEBA84" BorderColor="#DEBA84" BorderStyle="None" BorderWidth="1px" CellPadding="3" CellSpacing="2" DataKeyNames="Id" OnRowCommand="GridView1_RowCommand" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" Width="435px">
                   <Columns>
                       <asp:BoundField DataField="EmpName" HeaderText="EmpName" ReadOnly="True" SortExpression="EmpName" />
                       <asp:BoundField DataField="EmpAge" HeaderText="EmpAge" ReadOnly="True" SortExpression="EmpAge" />
                       <asp:BoundField DataField="EmpBirth" HeaderText="EmpBirth" ReadOnly="True" SortExpression="EmpBirth" />
                       <asp:ButtonField ButtonType="Button" CommandName="Edit" Text="編輯" />
                       <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="刪除" />
                   </Columns>
                   <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
                   <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
                   <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
                   <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
                   <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
                   <SortedAscendingCellStyle BackColor="#FFF1D4" />
                   <SortedAscendingHeaderStyle BackColor="#B95C30" />
                   <SortedDescendingCellStyle BackColor="#F1E5CE" />
                   <SortedDescendingHeaderStyle BackColor="#93451F" />
               </asp:GridView>
               <asp:SqlDataSource ID="WebDataSource" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:ConnectionStr %>" DeleteCommand="DELETE FROM [MemeberTable] WHERE [Id] = @original_Id AND [EmpName] = @original_EmpName AND [EmpAge] = @original_EmpAge AND [EmpBirth] = @original_EmpBirth" InsertCommand="INSERT INTO [MemeberTable] ([Id], [EmpName], [EmpAge], [EmpBirth]) VALUES (@Id, @EmpName, @EmpAge, @EmpBirth)" OldValuesParameterFormatString="original_{0}" ProviderName="<%$ ConnectionStrings:ConnectionStr.ProviderName %>" SelectCommand="SELECT * FROM [MemeberTable]" UpdateCommand="UPDATE [MemeberTable] SET [EmpName] = @EmpName, [EmpAge] = @EmpAge, [EmpBirth] = @EmpBirth WHERE [Id] = @original_Id AND [EmpName] = @original_EmpName AND [EmpAge] = @original_EmpAge AND [EmpBirth] = @original_EmpBirth">
                   <DeleteParameters>
                       <asp:Parameter Name="original_Id" Type="Int32" />
                       <asp:Parameter Name="original_EmpName" Type="String" />
                       <asp:Parameter Name="original_EmpAge" Type="Int32" />
                       <asp:Parameter Name="original_EmpBirth" Type="DateTime" />
                   </DeleteParameters>
                   <InsertParameters>
                       <asp:Parameter Name="Id" Type="Int32" />
                       <asp:Parameter Name="EmpName" Type="String" />
                       <asp:Parameter Name="EmpAge" Type="Int32" />
                       <asp:Parameter Name="EmpBirth" Type="DateTime" />
                   </InsertParameters>
                   <UpdateParameters>
                       <asp:Parameter Name="EmpName" Type="String" />
                       <asp:Parameter Name="EmpAge" Type="Int32" />
                       <asp:Parameter Name="EmpBirth" Type="DateTime" />
                       <asp:Parameter Name="original_Id" Type="Int32" />
                       <asp:Parameter Name="original_EmpName" Type="String" />
                       <asp:Parameter Name="original_EmpAge" Type="Int32" />
                       <asp:Parameter Name="original_EmpBirth" Type="DateTime" />
                   </UpdateParameters>
               </asp:SqlDataSource>

        </div>
     

    </main>

   
</asp:Content>
