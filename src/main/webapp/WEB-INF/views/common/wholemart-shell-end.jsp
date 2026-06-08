         <%-- Shared shell end: closes the panel/main/app wrapper opened in wholemart-shell-start.jsp. --%>
         </section>
     </main>
     <footer class="wm-footer">
         <div class="wm-footer-content">
             <div class="wm-footer-section">
                 <h4>About WholeMart</h4>
                 <p>WholeMart is a comprehensive wholesale distribution platform connecting distributors, retailers, and drivers for seamless commerce.</p>
             </div>
             <div class="wm-footer-section">
                 <h4>Quick Links</h4>
                 <ul>
                     <li><a href="/web/help">Help Center</a></li>
                     <li><a href="/web/about">About Us</a></li>
                     <li><a href="/web/contact">Contact Support</a></li>
                     <li><a href="/web/terms">Terms of Service</a></li>
                 </ul>
             </div>
             <div class="wm-footer-section">
                 <h4>Your Profile</h4>
                 <p><strong>Role:</strong> <span class="wm-role-badge"><%= wmRoleLabel %></span></p>
                 <p><strong>User:</strong> <%= wmUserName %></p>
             </div>
             <div class="wm-footer-section">
                 <h4>Support</h4>
                 <p>Email: <a href="mailto:support@wholemart.com">support@wholemart.com</a></p>
                 <p>Phone: 1-800-MART-HELP</p>
             </div>
         </div>
         <div class="wm-footer-bottom">
             <p>&copy; 2024 WholeMart. All rights reserved. | <a href="/web/privacy">Privacy Policy</a> | <a href="/web/terms">Terms</a></p>
         </div>
     </footer>
 </div>
 <script src="/js/common.js?v=project-theme-refresh-10"></script>
 </body>
 </html>
