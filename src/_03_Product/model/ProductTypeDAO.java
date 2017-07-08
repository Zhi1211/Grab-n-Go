package _03_Product.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import _00_init.GlobalService;

public class ProductTypeDAO {
	private DataSource ds = null;
	String restNameA;
	
	

	public String getRestNameA() {
		return restNameA;
	}

	public void setRestNameA(String restNameA) {
		this.restNameA = restNameA;
	}

	public ProductTypeDAO() {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup(GlobalService.JNDI_DB_NAME);

		} catch (NamingException e) {
			System.out.println("JNDI gets wrong ");
			e.printStackTrace();
		}
	}

	public void insertProductType(ProductType type) {
		
		String getIndex = "select max(type_no) from product_type";
		String sql = "insert into product_type values(?,?,?)";
		int result = -1;
		int maxIndex = 0;
		try (Connection con = ds.getConnection(); 
				PreparedStatement pst1 = con.prepareStatement(getIndex);) {
			try {
				con.setAutoCommit(false);
				ResultSet rs = pst1.executeQuery();
				while (rs.next()) {
					maxIndex = rs.getInt(1);
				}
				System.out.println("maxIndex = " + maxIndex + " in insertProductType");
				PreparedStatement pst = con.prepareStatement(sql);
				pst.setInt(1, ++maxIndex);
				pst.setString(2, type.getProd_typeName());
				pst.setString(3, type.getRest_name());
				result = pst.executeUpdate();
				con.commit();
				con.setAutoCommit(true);
			} catch (Exception e) {
				if(con!=null){
					con.rollback();
					System.out.println("新增類別錯誤 in ProductTypeDAO");
				}
			}
			if (result == 1) {
				System.out.println(type + " : 新增成功");
			} else {
				System.out.println(type + " : 新增失敗");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int deleteProductType(String typeName) {

		String sql = "delete from product_type where type_name=?";
		int result = -1;

		try (Connection con = ds.getConnection(); PreparedStatement pst = con.prepareStatement(sql);) {
			pst.setString(1,typeName);
			result = pst.executeUpdate();
			if (result == 1) {
				System.out.println(typeName + ": 刪除成功");
			} else {
				System.out.println(typeName + ": 刪除失敗");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public List<String> getAllProductType() {
		List<String> ptList = new ArrayList<String>();
		String sql = "select type_name from product_type where rest_name=?";

		try (Connection con = ds.getConnection(); 
				PreparedStatement pst = con.prepareStatement(sql);) {
			pst.setString(1,restNameA);
			ResultSet rs = pst.executeQuery();
			while(rs.next()){
				String typeName = rs.getString(1);
				ptList.add(typeName);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ptList;
	}
	
	
	public List<ProductType> queryAllProductType(String restName) {
		List<ProductType> ptList = new ArrayList<ProductType>();
		String sql = "select * from product_type where rest_name=?";
		ProductType pt = null;
		try (Connection con = ds.getConnection(); 
				PreparedStatement pst = con.prepareStatement(sql);) {
			pst.setString(1,restName);
			ResultSet rs = pst.executeQuery();
			while(rs.next()){
				int typeNo = rs.getInt(1);
				String typeName = rs.getString(2);
				pt = new ProductType(typeNo,typeName);
				ptList.add(pt);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ptList;
	}
	
	public int updateAllProductType(ProductType pt, int typeNo) {
		
		String sql = "update product_type set type_name = ? where type_no=?";
		int result = -1;
		
		try (Connection con = ds.getConnection(); 
				PreparedStatement pst = con.prepareStatement(sql);) {
			
			System.out.println(pt.getProd_typeName());
			pst.setString(1,pt.getProd_typeName());
			pst.setInt(2,typeNo);
			result = pst.executeUpdate();
			
			
			if (result == 1) {
				System.out.println(typeNo + ": 修改成功");
			} else {
				System.out.println(typeNo + ": 修改失敗");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
