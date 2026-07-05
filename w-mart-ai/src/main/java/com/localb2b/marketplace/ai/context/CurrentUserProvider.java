package com.localb2b.marketplace.ai.context;

import com.localb2b.marketplace.user.common.CurrentUser;
import com.localb2b.marketplace.user.UserAccount;
import com.localb2b.marketplace.user.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;

@Component("aiCurrentUserProvider")
public class CurrentUserProvider {
    private final com.localb2b.marketplace.user.common.CurrentUserProvider currentUserProvider;
    private final UserService userService;

    public CurrentUserProvider(com.localb2b.marketplace.user.common.CurrentUserProvider currentUserProvider,
                               UserService userService) {
        this.currentUserProvider = currentUserProvider;
        this.userService = userService;
    }

    public UserContext getCurrentUser() {
        CurrentUser currentUser = currentUserProvider.requireCurrentUser();
        return from(currentUser);
    }

    public UserContext getCurrentUser(HttpSession session) {
        CurrentUser currentUser = currentUserProvider.requireSessionUser(session);
        return from(currentUser);
    }

    public CurrentUser requireCommonCurrentUser() {
        return currentUserProvider.requireCurrentUser();
    }

    private UserContext from(CurrentUser currentUser) {
        UserAccount user = userService.requireActiveUser(currentUser);
        return new UserContext(user.getId(), user.getRole().name(), null, null, null, user.getName());
    }
}
