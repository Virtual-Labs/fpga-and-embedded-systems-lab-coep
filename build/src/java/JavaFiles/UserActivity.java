/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JavaFiles;

import extra.DbConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javabeans.UserData;

/**
 *
 * @author shree
 */
public class UserActivity {

    public int validateUser(String name, String password) {
        int message = 0;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String qry = "select username, password from fpgauserdata where username=?";
        int cnt=0;
        con = new DbConnect().getNewConnectionLogin();
        try {
            ps = con.prepareStatement(qry);
            ps.setString(1, name);
            rs = ps.executeQuery();
        
            while(rs.next())
            {
                cnt++;
                if(rs.getString("password").equals(password)){
                    cnt++;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserActivity.class.getName()).log(Level.SEVERE, null, ex);
        }
//        if(cnt==0){
//            message="You are not a registered member!!";
//        }
//        else if(cnt==1){
//            message="Password is wrong!!";
//        }
//        else if(cnt==2){
//            message="You are not a registered member!!";
//        }
        message=cnt;
        return message;
    }
    
    public int checkUser(String name) {
        int message = 0;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String qry = "select username from fpgauserdata where username=?";
        int cnt=0;
        con = new DbConnect().getNewConnectionLogin();
        try {
            ps = con.prepareStatement(qry);
            ps.setString(1, name);
            rs = ps.executeQuery();
        
            while(rs.next())
            {
                cnt++;
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserActivity.class.getName()).log(Level.SEVERE, null, ex);
        }

        message=cnt;
        return message;
    }

    public int registerUser(UserData ud) {
        int result = 999;
        PreparedStatement ps = null;
        Connection con = null;
        try {

            con = new DbConnect().getNewConnectionLogin();
            
            String qry = "INSERT into fpgauserdata values(?,?,?,?,?)";
            ps = con.prepareStatement(qry);
            ps.setString(1, ud.getName());
            ps.setString(2, ud.getUsername());
            ps.setString(3, ud.getEmail());
            ps.setString(4, ud.getCollege());
            ps.setString(5, ud.getPassword());

            result = ps.executeUpdate();




        } catch (SQLException ex) {
            Logger.getLogger(UserActivity.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                Logger.getLogger(UserActivity.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return result;
    }
}
