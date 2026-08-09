<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<footer class="wm-footer">
    <div class="container">
        <div class="row">
            <div class="col-lg-4">
                <h3>WholeMart</h3>
                <p>
                    <fmt:message key="footer.desc"/>
                </p>
            </div>
            <div class="col-lg-2">
                <h5><fmt:message key="footer.platform"/></h5>
                <ul class="list-unstyled">
                    <li><a href="#features"><fmt:message key="nav.impact"/></a></li>
                    <li><a href="#roles"><fmt:message key="nav.roles"/></a></li>
                    <li><a href="#operations"><fmt:message key="nav.operations"/></a></li>
                </ul>
            </div>
            <div class="col-lg-2">
                <h5><fmt:message key="footer.resources"/></h5>
                <ul class="list-unstyled">
                    <li><a href="#faq"><fmt:message key="nav.faq"/></a></li>
                    <li><a href="#"><fmt:message key="nav.support"/></a></li>
                    <li><a href="#"><fmt:message key="nav.privacy"/></a></li>
                </ul>
            </div>
            <div class="col-lg-4">
                <h5><fmt:message key="footer.contact"/></h5>
                <ul class="list-unstyled">
                    <li>Email: support@whole-mart.com</li>
                    <li>Contact: +917505115883</li>
                    <li>Address: 123 Wholesale Lane, Jaspur City, Uttarakhand 244712</li>
                </ul>
            </div>
        </div>
        <hr class="my-4">
        <div class="text-center text-muted">
            <fmt:message key="footer.copyright"/>
        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function setWmLanguage(lang) {
    window.location.href = "<%= request.getContextPath() %>/web/lang/" + encodeURIComponent(lang);
  }
  window.setWmLanguage = setWmLanguage;
</script>
