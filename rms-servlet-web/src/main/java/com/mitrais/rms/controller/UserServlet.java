package com.mitrais.rms.controller;

import com.mitrais.rms.dao.UserDao;
import com.mitrais.rms.dao.impl.UserDaoImpl;
import com.mitrais.rms.model.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Optional;

@WebServlet("/users/*")
public class UserServlet extends AbstractController
{
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        String path = getTemplatePath(req.getServletPath()+req.getPathInfo());

        if ("/list".equalsIgnoreCase(req.getPathInfo())){
            UserDao userDao = UserDaoImpl.getInstance();
            List<User> users = userDao.findAll();
            req.setAttribute("users", users);
        }
        else if ("/delete".equalsIgnoreCase(req.getPathInfo())) {
            long id = Integer.parseInt(req.getParameter("id"));
            UserDao userDao = UserDaoImpl.getInstance();
            User user = new User(id, "", "");
            userDao.delete(user);
            path="/users/list";
        }
        else if ("/update".equalsIgnoreCase(req.getPathInfo())){
            long id = Long.parseLong(req.getParameter("id"));
            UserDao userDao = UserDaoImpl.getInstance();
            Optional<User> users = userDao.find(id);
            req.setAttribute("user", users);
            path="/users/insert";
        }

        RequestDispatcher requestDispatcher = req.getRequestDispatcher(path);
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException
    {
        User user = new User();
        user.setUserName(req.getParameter("username"));
        user.setPassword(req.getParameter("password"));
        String id = req.getParameter("id");
        System.out.println("id === " + id);
        UserDao userDao = UserDaoImpl.getInstance();
        if (req.getParameter("save_button") != null) {
            if (id == null || id.isEmpty()) {
                userDao.save(user);
            } else {
                user.setId(Long.parseLong(id));
                userDao.update(user);
            }
            resp.sendRedirect("http://localhost:8080/rms-servlet-web/users/list");
        } else {
            resp.sendRedirect("http://localhost:8080/rms-servlet-web/users/list");
        }
    }
}
