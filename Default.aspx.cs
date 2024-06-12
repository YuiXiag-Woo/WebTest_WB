using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//主要執行位置
namespace WebTest_WB
{
    public partial class _Default : Page
    {
        //備註:WebForm只是用於SQL語法撰寫能力
        private SqlConnection conn;
        string contr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["ConnectionStr"].ConnectionString;//來自webCofig來源資料
        static int EditID = 0;//觸發Edit Grid編號
        protected void Page_Load(object sender, EventArgs e)
        {
            GridUpdate();//初始化讀檔
        }
        public void InsertAccount()
        {
            //Insert SQL語法寫入資料
            conn = new SqlConnection(contr);
            conn.Open();
            var insertCommand = "INSERT INTO MemeberTable (EmpName,EmpAge, EmpBirth) VALUES(@EmpName,@EmpAge, @EmpBirth)";
            
            SqlCommand cmd = new SqlCommand(insertCommand, conn);
            cmd.Parameters.Add("@EmpName", SqlDbType.NVarChar).Value =NameTB.Text;
            cmd.Parameters.Add("@EmpAge", SqlDbType.Int).Value =int.Parse( AgeTB.Text);
            cmd.Parameters.Add("@EmpBirth", SqlDbType.DateTime).Value =DateTime.Parse(BirthTB.Text);
            cmd.ExecuteNonQuery();
            conn.Close();
        }
       
        public void DeleteData(int deleteID)
        {
            //Delete SQL刪除資料
            conn = new SqlConnection(contr);
            conn.Open();
            var DeleteCommand = "DELETE FROM MemeberTable Where Id =" + deleteID;

            SqlCommand cmd = new SqlCommand(DeleteCommand, conn);           
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        public DataTable GridUpdate()
        {
            //更新(Select語法撈資料)
            var SelectCommand = "SELECT * FROM MemeberTable";
            SqlCommand cmd = new SqlCommand(SelectCommand, conn);
            DataTable dt = new DataTable();
            using (SqlDataAdapter sda = new SqlDataAdapter(SelectCommand, contr))
            {                              
                    sda.Fill(dt);
                    GridView1.DataSource = dt;                 
            }
            return dt;//需要dataTable取出Id
        }
        protected void CreateBtn_Click(object sender, EventArgs e)
        {
            InsertAccount();
            GridUpdate();//更新GridView1

        }
        
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            Button button = sender as Button;
            if (e.CommandName.Equals("Delete"))
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                if (rowIndex > GridView1.Rows.Count) return;
                GridViewRow row = GridView1.Rows[rowIndex];
                string Name = row.Cells[0].Text;
                int DeleteID = int.Parse(GridUpdate().Rows.Cast<DataRow>().First(a => a["EmpName"].Equals(Name))[0].ToString());//取得該編輯ID
                DeleteData(DeleteID);//針對ID刪除
                GridUpdate();//更新GridView1
            }
            if (e.CommandName.Equals("Edit"))
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = GridView1.Rows[rowIndex];
                NameTB.Text= row.Cells[0].Text;
                AgeTB.Text = row.Cells[1].Text;
                BirthTB.Text = row.Cells[2].Text;
                CreateBtn.Visible = false;
                EditBtn.Visible = true;
                EditID = int.Parse(GridUpdate().Rows.Cast<DataRow>().First(a => a["EmpName"].Equals(NameTB.Text))[0].ToString());//取得該編輯ID
                //針對ID改寫
            }

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //不用做，防錯
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            //不用做，防錯
        }
        public void UpdateRow()
        {
            //upDate SQL 語法
            conn = new SqlConnection(contr);
            conn.Open();
            var insertCommand = "UPDATE MemeberTable SET EmpName=@EmpName,EmpAge=@EmpAge, EmpBirth=@EmpBirth Where Id=@Id";//"Edit"按鈕取得

            SqlCommand cmd = new SqlCommand(insertCommand, conn);
            cmd.Parameters.Add("@EmpName", SqlDbType.NVarChar).Value = NameTB.Text;
            cmd.Parameters.Add("@EmpAge", SqlDbType.Int).Value = int.Parse(AgeTB.Text);
            cmd.Parameters.Add("@EmpBirth", SqlDbType.DateTime).Value = DateTime.Parse(BirthTB.Text);
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = EditID;
            
            cmd.ExecuteNonQuery();
            conn.Close();
        }
        protected void EditBtn_Click(object sender, EventArgs e)
        {
            CreateBtn.Visible = true;
            EditBtn.Visible = false;
            UpdateRow();
            GridUpdate();//更新GridView1
        }
            
    }
}