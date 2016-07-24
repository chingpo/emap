package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

public class PopuMutilAction extends MultiActionController {
	private PopuDao dao;

	public PopuDao getDao() {
		return dao;
	}

	public void setDao(PopuDao dao) {
		this.dao = dao;
	}

	int[] str = { 23, 21, 32, 37, 41, 42, 43, 45, 52 };
	String[] st = { "黑龙江", "辽宁", "江苏", "山东", "河南", "湖北", "湖南", "广西", "贵州" };
	String[] yearTable = { "popu_00", "popu_93", "popu_97", "popu_91",
			"popu_06", "popu_04" };
	String[] rkTable = { "c00people", "c97people", "c06people", "c04people" };
	Map<String, Integer> provinceCode = new HashMap<String, Integer>();

	public PopuMutilAction() {
		super();
		provinceCode.put("黑龙江", 23);
		provinceCode.put("辽宁", 21);
		provinceCode.put("江苏", 32);
		provinceCode.put("山东", 37);
		provinceCode.put("河南", 41);
		provinceCode.put("湖北", 42);
		provinceCode.put("湖南", 43);
		provinceCode.put("广西", 45);
		provinceCode.put("贵州", 52);
	}

	public ModelAndView mapDo(HttpServletRequest request,
			HttpServletResponse response) throws SQLException, IOException,
			ServletException {
		String table = request.getParameter("year");
		System.out.println(table);
		if (table.equals("2000"))
			table = "c00people";
		if (table.equals("1989"))
			table = "c89people";
		if (table.equals("1997"))
			table = "c97people";
		if (table.equals("1993"))
			table = "c93people";
		if (table.equals("1991"))
			table = "c91people";
		if (table.equals("2004"))
			table = "c04people";
		if (table.equals("2006"))
			table = "c06people";
		String sqlSelect = null;
		int count = 0;
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		for (int i = 0; i < str.length; i++) {
			int a = str[i];
			sqlSelect = "select count(t1) from " + table + " where t1='" + a
					+ "' and u1<>'null' ";
			System.out.println(sqlSelect);
			count = dao.queryForInt(sqlSelect);
			map.put(String.valueOf(st[i]), count);
		}
		ArrayList<data> array = new ArrayList<data>();
		for (String key1 : map.keySet()) {
			data arr1 = new data();
			arr1.setName(key1);
			arr1.setValue((map.get(key1)));
			array.add(arr1);
		}
		response.setContentType("text/html; charset=utf-8");
		JSONArray json = JSONArray.fromObject(array);
		System.out.println(json.toString());
		request.setAttribute("data", json);
		return new ModelAndView("/test.jsp");

	}

	public void rkDo(HttpServletRequest request,
			HttpServletResponse response) throws SQLException, IOException,
			ServletException {
	response.setContentType("text/html; charset=utf-8");
	PrintWriter out = response.getWriter();
		String table = request.getParameter("year2");
		String type = request.getParameter("type2");
		System.out.println("year----------------------------------"+table);
		System.out.println("type----------------------------------"+type);
		if(table!=null){
		if (table.equals("2000")){
			table = "c00people";
		}			
		if (table.equals("1997")){			
		    table = "c97people";
		}			
		if (table.equals("2004")){
			table = "c04people";
		}			
		if (table.equals("2006")){
			table = "c06people";
		}			
		}
		else{
				table="c00people";
		}		
		if (type != null) {
			if(type.equals("sn")){
				type = "u1<'15' and u1<>'null'";
				}
				if(type.equals("zn")){
				type="u1 between 15 and 65 and u1<>'null'";	
				}
				if(type.equals("ln")){
				type="u1>'65' and u1<>'null'";	
				}else {
					type = "u1<'15' and u1<>'null'";
				}			
		}
		else {
			type = "u1<'15' and u1<>'null'";
		}
		ArrayList<data> rkArray = new ArrayList<data>();
		for (Map.Entry<String, Integer> entry : provinceCode.entrySet()) {
			String sql2 = "select count(t1) from " + table
					+ " where t1='" + entry.getValue()
					+ "' and "+type+"";
			System.out.println(sql2);
			int jiegou = dao.queryForInt(sql2);
			data rkjg = new data();
			rkjg.setName(entry.getKey());
			rkjg.setValue(jiegou);
			rkArray.add(rkjg);
		}		
		JSONArray rkJson = JSONArray.fromObject(rkArray);
		System.out.println(type + table + rkJson.toString());
		out.write(rkJson.toString());
	    out.flush();
	    out.close();

	}
	
	public void nrkDo(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		for (int i = 0; i < rkTable.length; i++) {
			String table = rkTable[i];
			ArrayList<data> snArray = new ArrayList<data>();
			ArrayList<data> znArray = new ArrayList<data>();
			ArrayList<data> lnArray = new ArrayList<data>();
			for (Map.Entry<String, Integer> entry : provinceCode.entrySet()) {
				String sqlsn = "select count(t1) from " + table
						+ " where t1='" + entry.getValue()
						+ "' and "+"u1<'15' and u1<>'null'";
				String sqlzn = "select count(t1) from " + table
						+ " where t1='" + entry.getValue()
						+ "' and u1 between 15 and 65 and u1<>'null'";
				String sqlln = "select count(t1) from " + table
						+ " where t1='" + entry.getValue()
						+ "' and u1>'65' and u1<>'null'";
				System.out.println("sqlzn------------------"+sqlzn);
				int jiegousn = dao.queryForInt(sqlsn);
				int jiegouzn = dao.queryForInt(sqlzn);
				int jiegouln = dao.queryForInt(sqlln);
				data rkjgsn = new data();
				data rkjgzn = new data();
				data rkjgln = new data();
				rkjgsn.setName(entry.getKey());
				rkjgsn.setValue(jiegousn);
				snArray.add(rkjgzn);
				rkjgzn.setName(entry.getKey());
				rkjgzn.setValue(jiegouzn);
				znArray.add(rkjgzn);
				rkjgln.setName(entry.getKey());
				rkjgln.setValue(jiegouln);
				lnArray.add(rkjgln);
			}
			JSONArray snJson = JSONArray.fromObject(snArray);
			JSONArray znJson = JSONArray.fromObject(znArray);
			JSONArray lnJson = JSONArray.fromObject(lnArray);
			System.out.println("sn" + table + snJson.toString());
			System.out.println("zn" + table + znJson.toString());
			System.out.println("ln" + table + lnJson.toString());
			request.setAttribute("sn" + table, snJson);
			request.setAttribute("zn" + table, znJson);
			request.setAttribute("ln" + table, lnJson);
		}
		response.setContentType("text/html; charset=utf-8");
	}


	public ModelAndView rk2Do(HttpServletRequest request,
			HttpServletResponse response) throws SQLException, IOException,
			ServletException {
		String a = request.getParameter("sheng");

		for (int i = 0; i < rkTable.length; i++) {
			String table2 = rkTable[i];
			String snsql = "select count(t1) from " + table2 + " where t1='"
					+ a + "' and u1<'15' and u1<>'null'";
			String znsql = "select count(t1) from " + table2 + " where t1='"
					+ a + "' and u1 between 15 and 65 and u1<>'null' ";
			String lnsql = "select count(t1) from " + table2 + " where t1='"
					+ a + "' and u1>'65' and u1<>'null' ";
			int sn = dao.queryForInt(snsql);
			int zn = dao.queryForInt(znsql);
			int ln = dao.queryForInt(lnsql);
			HashMap<String, Integer> map = new HashMap<String, Integer>();
			map.put("<15", sn);
			map.put("15-65", zn);
			map.put(">65", ln);
			ArrayList<data> array = new ArrayList<data>();
			for (String key1 : map.keySet()) {
				data arr = new data();
				arr.setName(key1);
				arr.setValue((map.get(key1)));
				array.add(arr);
			}
			JSONArray json = JSONArray.fromObject(array);
			System.out.println(table2 + json.toString());
			request.setAttribute(table2, json);
		}
		response.setContentType("text/html; charset=utf-8");
		return new ModelAndView("/rk2.jsp");

	}

	public void barDo(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		String year = request.getParameter("year");
		String type = request.getParameter("type");
		System.out.println("year----------------------------------"+year);
		System.out.println("type----------------------------------"+type);
		if (year != null) {
			if (year.equals("1997")) {
				year = "popu_97";
			}
			if (year.equals("2000")) {
				year = "popu_00";
			}
			if (year.equals("2004")) {
				year = "popu_04";
			}
			if (year.equals("2006")) {
				year = "popu_06";
			}
			if (year.equals("1991")) {
				year = "popu_91";
			}
			if (year.equals("1993")) {
				year = "popu_93";
			}
		} else {
			year = "popu_00";
		}
		if (type == null) {
			type = "income1";
		}
			ArrayList<data> avgArray = new ArrayList<data>();
//			ArrayList<data> avgFarmArray = new ArrayList<data>();
//			ArrayList<data> avgFishArray = new ArrayList<data>();
			for (Map.Entry<String, Integer> entry : provinceCode.entrySet()) {
				String count = "select count("+type+")from " + year
						+ " where t1='" + entry.getValue()
						+ "' and "+type+"<>'0'";
				String sum = "select sum("+type+") from " + year
						+ " where t1='" + entry.getValue()
						+ "' and "+type+"<>'0'";
//				String countT_farm = "select count(t_farm) from " + table2
//						+ " where t1='" + entry.getValue()
//						+ "' and t_farm<>'0'";
//				String sumT_farm = "select sum(t_farm) from " + table2
//						+ " where t1='" + entry.getValue()
//						+ "' and t_farm<>'0'";
//				String countT_fish = "select count(t_fish) from " + table2
//						+ " where t1='" + entry.getValue()
//						+ "' and t_fish<>'0'";
//				String sumT_fish = "select sum(t_fish) from " + table2
//						+ " where t1='" + entry.getValue()
//						+ "' and t_fish<>'0'";
				int cou = dao.queryForInt(count);
				int total = dao.queryForInt(sum);
				int avg = 0;
				if (0 != cou) {
					avg = total / cou;
				}
				data avgData = new data();
				avgData.setName(entry.getKey());
				avgData.setValue(avg);
				avgArray.add(avgData);
//				int couFarm = dao.queryForInt(countT_farm);
//				int sumFarm = dao.queryForInt(sumT_farm);
//				int avgFarm = 0;
//				if (0 != couFarm) {
//					avgFarm = sumFarm / couFarm;
//				}
//				data avgFarmData = new data();
//				avgFarmData.setName(entry.getKey());
//				avgFarmData.setValue(avgFarm);
//				avgFarmArray.add(avgFarmData);
//				int couFish = dao.queryForInt(countT_fish);
//				int sumFish = dao.queryForInt(sumT_fish);
//				int avgFish = 0;
//				if (0 != couFish) {
//					avgFish = sumFish / couFish;
//				}
//				data avgFishData = new data();
//				avgFishData.setName(entry.getKey());
//				avgFishData.setValue(avgFish);
//				avgFishArray.add(avgFishData);
			}
			JSONArray avgJson = JSONArray.fromObject(avgArray);
//			JSONArray avgFarmJson = JSONArray.fromObject(avgFarmArray);
//			JSONArray avgFishJson = JSONArray.fromObject(avgFishArray);
			System.out.println(type + year + avgJson.toString());
//			System.out.println("farm" + year + avgFarmJson.toString());
//			System.out.println("fish" + year + avgFishJson.toString());
//			request.setAttribute("income" + table2, avgIncometJson);
//			request.setAttribute("farm" + table2, avgFarmJson);
//			request.setAttribute("fish" + table2, avgFishJson);
			out.write(avgJson.toString());
//			out.write("<div id=\"farm" + table2 + "\">" + avgIncometJson
//					+ "</div>");
//			out.write("<div id=\"fish" + table2 + "\">" + avgIncometJson
//					+ "</div>");

		out.flush();
		out.close();
	}
	
	public void nbarDo(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		for (int i = 0; i < yearTable.length; i++) {
			String table2 = yearTable[i];
			ArrayList<data> avgIncomeArray = new ArrayList<data>();
			ArrayList<data> avgFarmArray = new ArrayList<data>();
			ArrayList<data> avgFishArray = new ArrayList<data>();
			for (Map.Entry<String, Integer> entry : provinceCode.entrySet()) {
				String countIncome1 = "select count(income1) from " + table2+ " where t1='" + entry.getValue()+ "' and income1<>'0'";
				String sumIncome1 = "select sum(income1) from " + table2+ " where t1='" + entry.getValue()+ "' and income1<>'0'";
				String countT_farm = "select count(t_farm) from " + table2+ " where t1='" + entry.getValue()+ "' and t_farm<>'0'";
				String sumT_farm = "select sum(t_farm) from " + table2+ " where t1='" + entry.getValue()+ "' and t_farm<>'0'";
				String countT_fish = "select count(t_fish) from " + table2+ " where t1='" + entry.getValue()+ "' and t_fish<>'0'";
				String sumT_fish = "select sum(t_fish) from " + table2+ " where t1='" + entry.getValue()+ "' and t_fish<>'0'";
				int couIncome = dao.queryForInt(countIncome1);
				int sumIncome = dao.queryForInt(sumIncome1);
				int avgIncome = 0;
				if (0 != couIncome) {avgIncome = sumIncome / couIncome;}
				data avgIncometData = new data();
				avgIncometData.setName(entry.getKey());
				avgIncometData.setValue(avgIncome);
				avgIncomeArray.add(avgIncometData);
				int couFarm = dao.queryForInt(countT_farm);
				int sumFarm = dao.queryForInt(sumT_farm);
				int avgFarm = 0;
				if (0 != couFarm) {avgFarm = sumFarm / couFarm;}
				data avgFarmData = new data();
				avgFarmData.setName(entry.getKey());
				avgFarmData.setValue(avgFarm);
				avgFarmArray.add(avgFarmData);
				int couFish = dao.queryForInt(countT_fish);
				int sumFish = dao.queryForInt(sumT_fish);
				int avgFish = 0;
				if (0 != couFish) {avgFish = sumFish / couFish;}
				data avgFishData = new data();
				avgFishData.setName(entry.getKey());
				avgFishData.setValue(avgFish);
				avgFishArray.add(avgFishData);
			}
			JSONArray avgIncometJson = JSONArray.fromObject(avgIncomeArray);
			JSONArray avgFarmJson = JSONArray.fromObject(avgFarmArray);
			JSONArray avgFishJson = JSONArray.fromObject(avgFishArray);
			System.out.println("income" + table2 + avgIncometJson.toString());
			System.out.println("farm" + table2 + avgFarmJson.toString());
			System.out.println("fish" + table2 + avgFishJson.toString());
			request.setAttribute("income" + table2, avgIncometJson);
			request.setAttribute("farm" + table2, avgFarmJson);
			request.setAttribute("fish" + table2, avgFishJson);
		}
		response.setContentType("text/html; charset=utf-8");
	}

	public void emapDo(HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		String year = request.getParameter("nf");
		String type = request.getParameter("type");
		System.out.println(year + "" + type);
		String find = null;
		int a = 0;
		String sql = null;
		HashMap<String, Integer> map2 = new HashMap<String, Integer>();
		System.out.println(year);
		if (year == null) {
			type = "pi";
			year = "2000";
		}
		if (type.equals("rs")) {
			if (year.equals("1997")) {
				find = "c97people";
			}
			if (year.equals("2000")) {
				find = "c00people";
			}
			if (year.equals("2004")) {
				find = "c04people";
			}
			if (year.equals("2006")) {
				find = "c06people";
			}
		}
		if (type.equals("pi")) {
			if (year.equals("1991")) {
				find = "popu_91";
			}
			if (year.equals("1993")) {
				find = "popu_93";
			}
			if (year.equals("1997")) {
				find = "popu_97";
			}
			if (year.equals("2000")) {
				find = "popu_00";
			}
			if (year.equals("2004")) {
				find = "popu_04";
			}
			if (year.equals("2006")) {
				find = "popu_06";
			}
		}
		ArrayList<data> array2 = new ArrayList<data>();
		if(type.equals("country")) {
			find="country";
			Map<Integer, String> tempCode = new HashMap<Integer, String>();
			tempCode.put(1, "北京");
			tempCode.put(2, "天津");
			tempCode.put(3, "河北");
			tempCode.put(4, "山西");
			tempCode.put(5, "内蒙古");
			tempCode.put(6, "辽宁");
			tempCode.put(7, "吉林");
			tempCode.put(8, "黑龙江");
			tempCode.put(9, "上海");
			tempCode.put(10, "江苏");
			tempCode.put(11, "浙江");
			tempCode.put(12, "安徽");
			tempCode.put(13, "福建");
			tempCode.put(14, "江西");
			tempCode.put(15, "山东");
			tempCode.put(16, "河南");
			tempCode.put(17, "湖北");
			tempCode.put(18, "湖南");
			tempCode.put(19, "广东");
			tempCode.put(20, "广西");
			tempCode.put(21, "海南");
			tempCode.put(22, "重庆");
			tempCode.put(23, "四川");
			tempCode.put(24, "贵州");
			tempCode.put(25, "云南");
			tempCode.put(26, "西藏");
			tempCode.put(27, "陕西");
			tempCode.put(28, "甘肃");
			tempCode.put(29, "青海");
			tempCode.put(30, "宁夏");
			tempCode.put(31, "新疆");
			
			for(int i = 1 ; i<32;i++){
				String sqlt = "select y"+year+" from country where t1="+i;
				int result = dao.queryForInt(sqlt);
				data arr2 = new data();
				arr2.setName(tempCode.get(i));
				arr2.setValue(result);
				array2.add(arr2);
			}
		}else{

		for (int i = 0; i < str.length; i++) {
			a = str[i];
			int result = 0;
			String sql1 = "select count(t1) from " + find + " where t1='" + a
					+ "' and u1<>'null' ";
			String sql2 = "select sum(total) from " + find + " where t1='" + a
					+ "'";
			if (type.equals("rs")) {
				sql = sql1;
			}
			if (type.equals("pi")) {
				sql = sql2;
			}
			System.out.println(sql);
			result = dao.queryForInt(sql);
			map2.put(String.valueOf(st[i]), result);
		}
		for (String key1 : map2.keySet()) {
			data arr2 = new data();
			arr2.setName(key1);
			arr2.setValue((map2.get(key1)));
			array2.add(arr2);
		}
		}
		Comparator<data> comparator = new Comparator<data>(){

			public int compare(data o1, data o2) {
				// TODO Auto-generated method stub
				return o1.getValue()-o2.getValue();
			}  
		};

		Collections.sort(array2,comparator);
		response.setContentType("text/html; charset=utf-8");
		JSONArray json2 = JSONArray.fromObject(array2);
		System.out.println(json2.toString());
		request.setAttribute("map", json2);
		PrintWriter out = response.getWriter();
		out.write(json2.toString());
		out.flush();
		out.close();
	}

	public ModelAndView testDo(HttpServletRequest request,
			HttpServletResponse response) throws IOException, SQLException, ServletException {
		nbarDo(request, response);
		nrkDo(request, response);
		return new ModelAndView("/test2.jsp");
	}

}
