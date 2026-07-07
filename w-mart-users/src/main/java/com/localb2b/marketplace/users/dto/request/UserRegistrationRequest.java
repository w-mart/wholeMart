package com.localb2b.marketplace.users.dto.request;

import com.localb2b.marketplace.users.dto.request.registration.AddressRequest;
import com.localb2b.marketplace.users.dto.request.registration.BusinessInfoRequest;
import com.localb2b.marketplace.users.dto.request.registration.DistributorRequest;
import com.localb2b.marketplace.users.dto.request.registration.DocumentRequest;
import com.localb2b.marketplace.users.dto.request.registration.DriverRequest;
import com.localb2b.marketplace.users.dto.request.registration.PersonalInfoRequest;
import com.localb2b.marketplace.users.dto.request.registration.RetailerRequest;
import lombok.Data;

@Data
public class UserRegistrationRequest {

    private PersonalInfoRequest personalInfo = new PersonalInfoRequest();

    private BusinessInfoRequest businessInfo = new BusinessInfoRequest();

    private AddressRequest address = new AddressRequest();

    private RetailerRequest retailer = new RetailerRequest();

    private DistributorRequest distributor = new DistributorRequest();

    private DriverRequest driver = new DriverRequest();

    private DocumentRequest documents = new DocumentRequest();

}