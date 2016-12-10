/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cr.cdrb.web.edu.security.domains;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

/**
 *
 * @author Jayang
 */
public class EduUser implements java.io.Serializable, UserDetails {

    /**
     * Returns {@code true} if the supplied object is a {@code User} instance
     * with the same {@code username} value.
     * <p>
     * In other words, the objects are equal if they have the same username,
     * representing the same principal.
     */
    @Override
    public boolean equals(Object rhs) {
        if (rhs instanceof EduUser) {
            return username.equals(((EduUser) rhs).username);
        }
        return false;
    }

    /**
     * Returns the hashcode of the {@code username}.
     */
    @Override
    public int hashCode() {
        return username.hashCode();
    }
    //用户名(身份证号码)
    private String username;
    //用户密码
    private String password;
    //用户角色集合
    private List<Role> roles;
    ///角色名称
    private String rolename;
    //角色ID
    private Integer roleid;
    //角色描述
    private String rolecmt;
    //职工姓名
    private String workername;
    //职工单位
    private String company;
    //所属处室ID
    private String companypid;
    //职位类型描述，是否为正职，副职
    private String type_name;

    public String getType_name() {
        return type_name;
    }

    public void setType_name(String type_name) {
        this.type_name = type_name;
    }

    public int getType_id() {
        return type_id;
    }

    public void setType_id(int type_id) {
        this.type_id = type_id;
    }
    //
    private int type_id;

    public String getCompanypid() {
        return companypid;
    }

    public void setCompanypid(String companypid) {
        this.companypid = companypid;
    }
    //职工性别
    private String sex;
    ///职工出生日期
    //private java.util.Date birth;
    //职工民族
    private String nation;
    //职工政治面貌
    private String political;
    //职工部门
    private String department;
    //职工工班
    private String gang;
    //职工现任职务,工种
    private String post;
    //职工职称
    private String title;
    //职工现任工班
    private String cgang;
    //职工技术等级
    private String technicalgrade;
    //职工岗位
    private String station;
    ///SpringSecurity权限集合
    private Collection<SimpleGrantedAuthority> authorities;
    ///账户是否过期
    private boolean accountNonExpired;
    //系统名称
    private String system;
    //部门ID
    private String departmentId;
    //单位ID
    private String companyId;
    //学历
    private String xl;

    private List<Groups> groups;

    public List<Groups> getGroups() {
        return groups;
    }

    public void setGroups(List<Groups> groups) {
        this.groups = groups;
    }

    public String getSystem() {
        return system;
    }

    public void setSystem(String system) {
        this.system = system;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getCompanyId() {
        return companyId;
    }

    public void setCompanyId(String companyId) {
        this.companyId = companyId;
    }

    public Collection<SimpleGrantedAuthority> getAuthorities() {
        return authorities;
    }

    public void setAuthorities(Collection<SimpleGrantedAuthority> authorities) {
        this.authorities = authorities;
    }

    @Override
    public boolean isAccountNonExpired() {
        return accountNonExpired;
    }

    public void setAccountNonExpired(boolean accountNonExpired) {
        this.accountNonExpired = accountNonExpired;
    }

    @Override
    public boolean isAccountNonLocked() {
        return accountNonLocked;
    }

    public void setAccountNonLocked(boolean accountNonLocked) {
        this.accountNonLocked = accountNonLocked;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return credentialsNonExpired;
    }

    public void setCredentialsNonExpired(boolean credentialsNonExpired) {
        this.credentialsNonExpired = credentialsNonExpired;
    }

    @Override
    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }
    private boolean accountNonLocked;
    private boolean credentialsNonExpired;
    private boolean enabled;

    public String getWorkername() {
        return workername;
    }

    public void setWorkername(String workername) {
        this.workername = workername;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

//    public Date getBirth() {
//        return birth;
//    }
//
//    public void setBirth(Date birth) {
//        this.birth = birth;
//    }
    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getPolitical() {
        return political;
    }

    public void setPolitical(String political) {
        this.political = political;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getGang() {
        return gang;
    }

    public void setGang(String gang) {
        this.gang = gang;
    }

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCgang() {
        return cgang;
    }

    public void setCgang(String cgang) {
        this.cgang = cgang;
    }

    public String getTechnicalgrade() {
        return technicalgrade;
    }

    public void setTechnicalgrade(String technicalgrade) {
        this.technicalgrade = technicalgrade;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getRolecmt() {
        return rolecmt;
    }

    public void setRolecmt(String rolecmt) {
        this.rolecmt = rolecmt;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public String getRole() {
        return rolename;
    }

    public void setRole(String rolename) {
        this.rolename = rolename;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    /**
     * @return the xl
     */
    public String getXl() {
        return xl;
    }

    /**
     * @param xl the xl to set
     */
    public void setXl(String xl) {
        this.xl = xl;
    }
}
