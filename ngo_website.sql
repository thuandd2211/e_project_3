
CREATE TABLE Blog
( 
	BlogId               int IDENTITY ( 1,1 ) ,
	Name                 text  NULL ,
	Author               char(30)  NULL ,
	CurrentTime          datetime  NULL ,
	Title1               char(100)  NULL ,
	Script1              text  NULL ,
	Img1                 image  NULL ,
	Title2               char(100)  NULL ,
	Script2              text  NULL ,
	Img2                 image  NULL ,
	Title3               char(100)  NULL ,
	Script3              text  NULL ,
	Img3                 image  NULL ,
	EmpId                int  NULL 
)
go



ALTER TABLE Blog
	ADD CONSTRAINT XPKBlog PRIMARY KEY  CLUSTERED (BlogId ASC)
go



CREATE TABLE Campaign
( 
	CampId               int IDENTITY ( 1,1 ) ,
	Name                 varchar(100)  NULL ,
	CurrentTime          datetime  NULL ,
	CompleteTime         char(18)  NULL ,
	CategoryId           int  NULL ,
	EmpId                int  NULL ,
	NgoId                int  NULL 
)
go



ALTER TABLE Campaign
	ADD CONSTRAINT XPKCampaign PRIMARY KEY  CLUSTERED (CampId ASC)
go



CREATE TABLE Campaign_Detail
( 
	Camp_DeId            int IDENTITY ( 1,1 ) ,
	Title1               char(50)  NULL ,
	Script1              text  NULL ,
	Img1                 image  NULL ,
	Title2               char(50)  NULL ,
	Script2              text  NULL ,
	Img2                 image  NULL ,
	Title3               char(50)  NULL ,
	Script3              text  NULL ,
	Img3                 image  NULL 
)
go



ALTER TABLE Campaign_Detail
	ADD CONSTRAINT XPKCampaign_Detail PRIMARY KEY  CLUSTERED (Camp_DeId ASC)
go



CREATE TABLE Category
( 
	CategoryId           int IDENTITY ( 1,1 ) ,
	Name                 char(50)  NULL ,
	Overview_Script      text  NULL ,
	Overview_Img         varbinary  NULL ,
	Detail_Script        text  NULL ,
	Detail_Img           varbinary  NULL 
)
go



ALTER TABLE Category
	ADD CONSTRAINT XPKCategory PRIMARY KEY  CLUSTERED (CategoryId ASC)
go



CREATE TABLE Donor
( 
	DonorId              int IDENTITY ( 1,1 ) ,
	Fullname             char(50)  NULL ,
	Birthday             datetime  NULL ,
	Email                char(50)  NULL ,
	Phone                int  NULL ,
	Username             char(18)  NULL ,
	Password             char(18)  NULL 
)
go



ALTER TABLE Donor
	ADD CONSTRAINT XPKDonor PRIMARY KEY  CLUSTERED (DonorId ASC)
go



CREATE TABLE Employee
( 
	EmpId                int IDENTITY ( 1,1 ) ,
	Fullname             char(50)  NULL ,
	Birthday             datetime  NULL ,
	Email                char(30)  NULL ,
	Phone                int  NULL ,
	Username             char(18)  NULL ,
	Password             char(18)  NULL 
)
go



ALTER TABLE Employee
	ADD CONSTRAINT XPKEmployee PRIMARY KEY  CLUSTERED (EmpId ASC)
go



CREATE TABLE Expense
( 
	ExpenseId            int IDENTITY ( 1,1 ) ,
	Name                 char(100)  NULL ,
	Amount               float  NULL ,
	Description          text  NULL 
)
go



ALTER TABLE Expense
	ADD CONSTRAINT XPKExpense PRIMARY KEY  CLUSTERED (ExpenseId ASC)
go



CREATE TABLE Fund
( 
	FundId               int IDENTITY ( 1,1 ) ,
	Name                 char(100)  NULL ,
	Total                float  NULL ,
	Description          text  NULL 
)
go



ALTER TABLE Fund
	ADD CONSTRAINT XPKFund PRIMARY KEY  CLUSTERED (FundId ASC)
go



CREATE TABLE Groups
( 
	GroupId              int IDENTITY ( 1,1 ) ,
	Name                 char(70)  NULL 
)
go



ALTER TABLE Groups
	ADD CONSTRAINT XPKGroups PRIMARY KEY  CLUSTERED (GroupId ASC)
go



CREATE TABLE Ngo
( 
	NgoId                int IDENTITY ( 1,1 ) ,
	Name                 char(50)  NULL ,
	Email                char(30)  NULL ,
	Phone                int  NULL ,
	Address              char(200)  NULL ,
	Image                image  NULL 
)
go



ALTER TABLE Ngo
	ADD CONSTRAINT XPKNgo PRIMARY KEY  CLUSTERED (NgoId ASC)
go



CREATE TABLE Payment
( 
	PaymentId            integer IDENTITY ( 1,1 ) ,
	Total                float  NULL ,
	Reason               text  NULL ,
	CurrentTime          datetime  NULL ,
	CampId               int  NULL ,
	FundId               int  NULL 
)
go



ALTER TABLE Payment
	ADD CONSTRAINT XPKPayment PRIMARY KEY  CLUSTERED (PaymentId ASC)
go



CREATE TABLE PaymentMethod
( 
	PayMethodId          int IDENTITY ( 1,1 ) ,
	Name                 char(30)  NULL 
)
go



ALTER TABLE PaymentMethod
	ADD CONSTRAINT XPKPaymentMethod PRIMARY KEY  CLUSTERED (PayMethodId ASC)
go



CREATE TABLE REF_CAMP_BLOG
( 
	CampId               int  NOT NULL ,
	BlogId               int  NOT NULL 
)
go



ALTER TABLE REF_CAMP_BLOG
	ADD CONSTRAINT XPKREF_CAMP_BLOG PRIMARY KEY  CLUSTERED (CampId ASC,BlogId ASC)
go



CREATE TABLE REF_DONOR_FUND
( 
	DonorId              int  NOT NULL ,
	FundId               int  NOT NULL ,
	Total                float  NULL 
)
go



ALTER TABLE REF_DONOR_FUND
	ADD CONSTRAINT XPKREF_DONOR_FUND PRIMARY KEY  CLUSTERED (DonorId ASC,FundId ASC)
go



CREATE TABLE REF_EMP_GROUP
( 
	EmpId                int  NOT NULL ,
	GroupId              int  NOT NULL 
)
go



ALTER TABLE REF_EMP_GROUP
	ADD CONSTRAINT XPKREF_EMP_GROUP PRIMARY KEY  CLUSTERED (EmpId ASC,GroupId ASC)
go



CREATE TABLE REF_EXPENSE_PAYMENT
( 
	ExpenseId            int  NOT NULL ,
	PaymentId            integer  NOT NULL ,
	Total                float  NULL 
)
go



ALTER TABLE REF_EXPENSE_PAYMENT
	ADD CONSTRAINT XPKREF_EXPENSE_PAYMENT PRIMARY KEY  CLUSTERED (ExpenseId ASC,PaymentId ASC)
go



CREATE TABLE REF_FUND_CAMP_DONOR
( 
	FundId               int  NOT NULL ,
	CampId               int  NOT NULL ,
	DonorId              int  NOT NULL ,
	CurrentTime          datetime  NULL ,
	Description          text  NULL ,
	Total                float  NULL ,
	PayMethodId          int  NULL 
)
go



ALTER TABLE REF_FUND_CAMP_DONOR
	ADD CONSTRAINT XPKREF_FUND_CAMP_DONOR PRIMARY KEY  CLUSTERED (FundId ASC,CampId ASC,DonorId ASC)
go



CREATE TABLE REF_GROUPS_ROLE
( 
	GroupId              int  NOT NULL ,
	RoleId               int  NOT NULL 
)
go



ALTER TABLE REF_GROUPS_ROLE
	ADD CONSTRAINT XPKREF_GROUPS_ROLE PRIMARY KEY  CLUSTERED (GroupId ASC,RoleId ASC)
go



CREATE TABLE Role
( 
	RoleId               int IDENTITY ( 1,1 ) ,
	Name                 char(100)  NULL 
)
go



ALTER TABLE Role
	ADD CONSTRAINT XPKRole PRIMARY KEY  CLUSTERED (RoleId ASC)
go




ALTER TABLE Blog
	ADD CONSTRAINT R_22 FOREIGN KEY (EmpId) REFERENCES Employee(EmpId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Campaign
	ADD CONSTRAINT R_21 FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Campaign
	ADD CONSTRAINT R_23 FOREIGN KEY (EmpId) REFERENCES Employee(EmpId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Campaign
	ADD CONSTRAINT R_24 FOREIGN KEY (NgoId) REFERENCES Ngo(NgoId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Payment
	ADD CONSTRAINT R_28 FOREIGN KEY (CampId) REFERENCES Campaign(CampId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Payment
	ADD CONSTRAINT R_32 FOREIGN KEY (FundId) REFERENCES Fund(FundId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_CAMP_BLOG
	ADD CONSTRAINT R_25 FOREIGN KEY (CampId) REFERENCES Campaign(CampId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_CAMP_BLOG
	ADD CONSTRAINT R_27 FOREIGN KEY (BlogId) REFERENCES Blog(BlogId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_DONOR_FUND
	ADD CONSTRAINT R_33 FOREIGN KEY (DonorId) REFERENCES Donor(DonorId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_DONOR_FUND
	ADD CONSTRAINT R_35 FOREIGN KEY (FundId) REFERENCES Fund(FundId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_EMP_GROUP
	ADD CONSTRAINT R_18 FOREIGN KEY (EmpId) REFERENCES Employee(EmpId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_EMP_GROUP
	ADD CONSTRAINT R_20 FOREIGN KEY (GroupId) REFERENCES Groups(GroupId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_EXPENSE_PAYMENT
	ADD CONSTRAINT R_29 FOREIGN KEY (ExpenseId) REFERENCES Expense(ExpenseId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_EXPENSE_PAYMENT
	ADD CONSTRAINT R_31 FOREIGN KEY (PaymentId) REFERENCES Payment(PaymentId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_FUND_CAMP_DONOR
	ADD CONSTRAINT R_36 FOREIGN KEY (FundId) REFERENCES Fund(FundId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_FUND_CAMP_DONOR
	ADD CONSTRAINT R_38 FOREIGN KEY (CampId) REFERENCES Campaign(CampId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_FUND_CAMP_DONOR
	ADD CONSTRAINT R_39 FOREIGN KEY (DonorId) REFERENCES Donor(DonorId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_FUND_CAMP_DONOR
	ADD CONSTRAINT R_40 FOREIGN KEY (PayMethodId) REFERENCES PaymentMethod(PayMethodId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_GROUPS_ROLE
	ADD CONSTRAINT R_15 FOREIGN KEY (GroupId) REFERENCES Groups(GroupId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE REF_GROUPS_ROLE
	ADD CONSTRAINT R_17 FOREIGN KEY (RoleId) REFERENCES Role(RoleId)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




CREATE TRIGGER tD_Blog ON Blog FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Blog */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Blog  REF_CAMP_BLOG on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00020676", PARENT_OWNER="", PARENT_TABLE="Blog"
    CHILD_OWNER="", CHILD_TABLE="REF_CAMP_BLOG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="BlogId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_CAMP_BLOG
      WHERE
        /*  %JoinFKPK(REF_CAMP_BLOG,deleted," = "," AND") */
        REF_CAMP_BLOG.BlogId = deleted.BlogId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Blog because REF_CAMP_BLOG exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Employee  Blog on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Blog"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="EmpId" */
    IF EXISTS (SELECT * FROM deleted,Employee
      WHERE
        /* %JoinFKPK(deleted,Employee," = "," AND") */
        deleted.EmpId = Employee.EmpId AND
        NOT EXISTS (
          SELECT * FROM Blog
          WHERE
            /* %JoinFKPK(Blog,Employee," = "," AND") */
            Blog.EmpId = Employee.EmpId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Blog because Employee exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Blog ON Blog FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Blog */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insBlogId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Blog  REF_CAMP_BLOG on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000265cc", PARENT_OWNER="", PARENT_TABLE="Blog"
    CHILD_OWNER="", CHILD_TABLE="REF_CAMP_BLOG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="BlogId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(BlogId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_CAMP_BLOG
      WHERE
        /*  %JoinFKPK(REF_CAMP_BLOG,deleted," = "," AND") */
        REF_CAMP_BLOG.BlogId = deleted.BlogId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Blog because REF_CAMP_BLOG exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Employee  Blog on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Blog"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="EmpId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(EmpId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Employee
        WHERE
          /* %JoinFKPK(inserted,Employee) */
          inserted.EmpId = Employee.EmpId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.EmpId IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Blog because Employee does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Campaign ON Campaign FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Campaign */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Campaign  REF_CAMP_BLOG on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00062004", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="REF_CAMP_BLOG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="CampId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_CAMP_BLOG
      WHERE
        /*  %JoinFKPK(REF_CAMP_BLOG,deleted," = "," AND") */
        REF_CAMP_BLOG.CampId = deleted.CampId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Campaign because REF_CAMP_BLOG exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Campaign  Payment on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="CampId" */
    IF EXISTS (
      SELECT * FROM deleted,Payment
      WHERE
        /*  %JoinFKPK(Payment,deleted," = "," AND") */
        Payment.CampId = deleted.CampId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Campaign because Payment exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Campaign  REF_FUND_CAMP_DONOR on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_38", FK_COLUMNS="CampId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_FUND_CAMP_DONOR
      WHERE
        /*  %JoinFKPK(REF_FUND_CAMP_DONOR,deleted," = "," AND") */
        REF_FUND_CAMP_DONOR.CampId = deleted.CampId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Campaign because REF_FUND_CAMP_DONOR exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Category  Campaign on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="CategoryId" */
    IF EXISTS (SELECT * FROM deleted,Category
      WHERE
        /* %JoinFKPK(deleted,Category," = "," AND") */
        deleted.CategoryId = Category.CategoryId AND
        NOT EXISTS (
          SELECT * FROM Campaign
          WHERE
            /* %JoinFKPK(Campaign,Category," = "," AND") */
            Campaign.CategoryId = Category.CategoryId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Campaign because Category exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Employee  Campaign on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="EmpId" */
    IF EXISTS (SELECT * FROM deleted,Employee
      WHERE
        /* %JoinFKPK(deleted,Employee," = "," AND") */
        deleted.EmpId = Employee.EmpId AND
        NOT EXISTS (
          SELECT * FROM Campaign
          WHERE
            /* %JoinFKPK(Campaign,Employee," = "," AND") */
            Campaign.EmpId = Employee.EmpId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Campaign because Employee exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Ngo  Campaign on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Ngo"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="NgoId" */
    IF EXISTS (SELECT * FROM deleted,Ngo
      WHERE
        /* %JoinFKPK(deleted,Ngo," = "," AND") */
        deleted.NgoId = Ngo.NgoId AND
        NOT EXISTS (
          SELECT * FROM Campaign
          WHERE
            /* %JoinFKPK(Campaign,Ngo," = "," AND") */
            Campaign.NgoId = Ngo.NgoId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Campaign because Ngo exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Campaign ON Campaign FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Campaign */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insCampId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Campaign  REF_CAMP_BLOG on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00072b21", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="REF_CAMP_BLOG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="CampId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CampId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_CAMP_BLOG
      WHERE
        /*  %JoinFKPK(REF_CAMP_BLOG,deleted," = "," AND") */
        REF_CAMP_BLOG.CampId = deleted.CampId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Campaign because REF_CAMP_BLOG exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Campaign  Payment on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="CampId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CampId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Payment
      WHERE
        /*  %JoinFKPK(Payment,deleted," = "," AND") */
        Payment.CampId = deleted.CampId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Campaign because Payment exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Campaign  REF_FUND_CAMP_DONOR on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_38", FK_COLUMNS="CampId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CampId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_FUND_CAMP_DONOR
      WHERE
        /*  %JoinFKPK(REF_FUND_CAMP_DONOR,deleted," = "," AND") */
        REF_FUND_CAMP_DONOR.CampId = deleted.CampId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Campaign because REF_FUND_CAMP_DONOR exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Category  Campaign on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="CategoryId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CategoryId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Category
        WHERE
          /* %JoinFKPK(inserted,Category) */
          inserted.CategoryId = Category.CategoryId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.CategoryId IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Campaign because Category does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Employee  Campaign on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="EmpId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(EmpId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Employee
        WHERE
          /* %JoinFKPK(inserted,Employee) */
          inserted.EmpId = Employee.EmpId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.EmpId IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Campaign because Employee does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Ngo  Campaign on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Ngo"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="NgoId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(NgoId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Ngo
        WHERE
          /* %JoinFKPK(inserted,Ngo) */
          inserted.NgoId = Ngo.NgoId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.NgoId IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Campaign because Ngo does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Category ON Category FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Category */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Category  Campaign on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000ef2d", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="CategoryId" */
    IF EXISTS (
      SELECT * FROM deleted,Campaign
      WHERE
        /*  %JoinFKPK(Campaign,deleted," = "," AND") */
        Campaign.CategoryId = deleted.CategoryId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Category because Campaign exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Category ON Category FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Category */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insCategoryId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Category  Campaign on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0001077d", PARENT_OWNER="", PARENT_TABLE="Category"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="CategoryId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(CategoryId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Campaign
      WHERE
        /*  %JoinFKPK(Campaign,deleted," = "," AND") */
        Campaign.CategoryId = deleted.CategoryId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Category because Campaign exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Donor ON Donor FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Donor */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Donor  REF_DONOR_FUND on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00020077", PARENT_OWNER="", PARENT_TABLE="Donor"
    CHILD_OWNER="", CHILD_TABLE="REF_DONOR_FUND"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="DonorId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_DONOR_FUND
      WHERE
        /*  %JoinFKPK(REF_DONOR_FUND,deleted," = "," AND") */
        REF_DONOR_FUND.DonorId = deleted.DonorId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Donor because REF_DONOR_FUND exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Donor  REF_FUND_CAMP_DONOR on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Donor"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="DonorId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_FUND_CAMP_DONOR
      WHERE
        /*  %JoinFKPK(REF_FUND_CAMP_DONOR,deleted," = "," AND") */
        REF_FUND_CAMP_DONOR.DonorId = deleted.DonorId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Donor because REF_FUND_CAMP_DONOR exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Donor ON Donor FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Donor */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insDonorId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Donor  REF_DONOR_FUND on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00023873", PARENT_OWNER="", PARENT_TABLE="Donor"
    CHILD_OWNER="", CHILD_TABLE="REF_DONOR_FUND"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="DonorId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DonorId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_DONOR_FUND
      WHERE
        /*  %JoinFKPK(REF_DONOR_FUND,deleted," = "," AND") */
        REF_DONOR_FUND.DonorId = deleted.DonorId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Donor because REF_DONOR_FUND exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Donor  REF_FUND_CAMP_DONOR on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Donor"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="DonorId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(DonorId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_FUND_CAMP_DONOR
      WHERE
        /*  %JoinFKPK(REF_FUND_CAMP_DONOR,deleted," = "," AND") */
        REF_FUND_CAMP_DONOR.DonorId = deleted.DonorId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Donor because REF_FUND_CAMP_DONOR exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Employee ON Employee FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Employee */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Employee  REF_EMP_GROUP on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002b2c7", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="REF_EMP_GROUP"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="EmpId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_EMP_GROUP
      WHERE
        /*  %JoinFKPK(REF_EMP_GROUP,deleted," = "," AND") */
        REF_EMP_GROUP.EmpId = deleted.EmpId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Employee because REF_EMP_GROUP exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Employee  Blog on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Blog"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="EmpId" */
    IF EXISTS (
      SELECT * FROM deleted,Blog
      WHERE
        /*  %JoinFKPK(Blog,deleted," = "," AND") */
        Blog.EmpId = deleted.EmpId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Employee because Blog exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Employee  Campaign on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="EmpId" */
    IF EXISTS (
      SELECT * FROM deleted,Campaign
      WHERE
        /*  %JoinFKPK(Campaign,deleted," = "," AND") */
        Campaign.EmpId = deleted.EmpId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Employee because Campaign exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Employee ON Employee FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Employee */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insEmpId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Employee  REF_EMP_GROUP on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002f63c", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="REF_EMP_GROUP"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="EmpId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(EmpId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_EMP_GROUP
      WHERE
        /*  %JoinFKPK(REF_EMP_GROUP,deleted," = "," AND") */
        REF_EMP_GROUP.EmpId = deleted.EmpId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Employee because REF_EMP_GROUP exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Employee  Blog on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Blog"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="EmpId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(EmpId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Blog
      WHERE
        /*  %JoinFKPK(Blog,deleted," = "," AND") */
        Blog.EmpId = deleted.EmpId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Employee because Blog exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Employee  Campaign on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="EmpId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(EmpId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Campaign
      WHERE
        /*  %JoinFKPK(Campaign,deleted," = "," AND") */
        Campaign.EmpId = deleted.EmpId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Employee because Campaign exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Expense ON Expense FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Expense */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Expense  REF_EXPENSE_PAYMENT on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00010f3c", PARENT_OWNER="", PARENT_TABLE="Expense"
    CHILD_OWNER="", CHILD_TABLE="REF_EXPENSE_PAYMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="ExpenseId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_EXPENSE_PAYMENT
      WHERE
        /*  %JoinFKPK(REF_EXPENSE_PAYMENT,deleted," = "," AND") */
        REF_EXPENSE_PAYMENT.ExpenseId = deleted.ExpenseId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Expense because REF_EXPENSE_PAYMENT exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Expense ON Expense FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Expense */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insExpenseId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Expense  REF_EXPENSE_PAYMENT on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00011ee5", PARENT_OWNER="", PARENT_TABLE="Expense"
    CHILD_OWNER="", CHILD_TABLE="REF_EXPENSE_PAYMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="ExpenseId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ExpenseId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_EXPENSE_PAYMENT
      WHERE
        /*  %JoinFKPK(REF_EXPENSE_PAYMENT,deleted," = "," AND") */
        REF_EXPENSE_PAYMENT.ExpenseId = deleted.ExpenseId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Expense because REF_EXPENSE_PAYMENT exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Fund ON Fund FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Fund */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Fund  Payment on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002c8dc", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="FundId" */
    IF EXISTS (
      SELECT * FROM deleted,Payment
      WHERE
        /*  %JoinFKPK(Payment,deleted," = "," AND") */
        Payment.FundId = deleted.FundId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Fund because Payment exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Fund  REF_DONOR_FUND on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="REF_DONOR_FUND"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="FundId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_DONOR_FUND
      WHERE
        /*  %JoinFKPK(REF_DONOR_FUND,deleted," = "," AND") */
        REF_DONOR_FUND.FundId = deleted.FundId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Fund because REF_DONOR_FUND exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Fund  REF_FUND_CAMP_DONOR on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="FundId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_FUND_CAMP_DONOR
      WHERE
        /*  %JoinFKPK(REF_FUND_CAMP_DONOR,deleted," = "," AND") */
        REF_FUND_CAMP_DONOR.FundId = deleted.FundId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Fund because REF_FUND_CAMP_DONOR exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Fund ON Fund FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Fund */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insFundId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Fund  Payment on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000315fa", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="FundId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(FundId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Payment
      WHERE
        /*  %JoinFKPK(Payment,deleted," = "," AND") */
        Payment.FundId = deleted.FundId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Fund because Payment exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Fund  REF_DONOR_FUND on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="REF_DONOR_FUND"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="FundId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(FundId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_DONOR_FUND
      WHERE
        /*  %JoinFKPK(REF_DONOR_FUND,deleted," = "," AND") */
        REF_DONOR_FUND.FundId = deleted.FundId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Fund because REF_DONOR_FUND exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Fund  REF_FUND_CAMP_DONOR on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="FundId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(FundId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_FUND_CAMP_DONOR
      WHERE
        /*  %JoinFKPK(REF_FUND_CAMP_DONOR,deleted," = "," AND") */
        REF_FUND_CAMP_DONOR.FundId = deleted.FundId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Fund because REF_FUND_CAMP_DONOR exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Groups ON Groups FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Groups */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Groups  REF_GROUPS_ROLE on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001efa6", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="REF_GROUPS_ROLE"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="GroupId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_GROUPS_ROLE
      WHERE
        /*  %JoinFKPK(REF_GROUPS_ROLE,deleted," = "," AND") */
        REF_GROUPS_ROLE.GroupId = deleted.GroupId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Groups because REF_GROUPS_ROLE exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Groups  REF_EMP_GROUP on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="REF_EMP_GROUP"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="GroupId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_EMP_GROUP
      WHERE
        /*  %JoinFKPK(REF_EMP_GROUP,deleted," = "," AND") */
        REF_EMP_GROUP.GroupId = deleted.GroupId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Groups because REF_EMP_GROUP exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Groups ON Groups FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Groups */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insGroupId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Groups  REF_GROUPS_ROLE on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000222f4", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="REF_GROUPS_ROLE"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="GroupId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(GroupId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_GROUPS_ROLE
      WHERE
        /*  %JoinFKPK(REF_GROUPS_ROLE,deleted," = "," AND") */
        REF_GROUPS_ROLE.GroupId = deleted.GroupId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Groups because REF_GROUPS_ROLE exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Groups  REF_EMP_GROUP on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="REF_EMP_GROUP"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="GroupId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(GroupId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_EMP_GROUP
      WHERE
        /*  %JoinFKPK(REF_EMP_GROUP,deleted," = "," AND") */
        REF_EMP_GROUP.GroupId = deleted.GroupId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Groups because REF_EMP_GROUP exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Ngo ON Ngo FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Ngo */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Ngo  Campaign on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000e10f", PARENT_OWNER="", PARENT_TABLE="Ngo"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="NgoId" */
    IF EXISTS (
      SELECT * FROM deleted,Campaign
      WHERE
        /*  %JoinFKPK(Campaign,deleted," = "," AND") */
        Campaign.NgoId = deleted.NgoId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Ngo because Campaign exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Ngo ON Ngo FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Ngo */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insNgoId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Ngo  Campaign on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0000fe4a", PARENT_OWNER="", PARENT_TABLE="Ngo"
    CHILD_OWNER="", CHILD_TABLE="Campaign"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_24", FK_COLUMNS="NgoId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(NgoId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Campaign
      WHERE
        /*  %JoinFKPK(Campaign,deleted," = "," AND") */
        Campaign.NgoId = deleted.NgoId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Ngo because Campaign exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Payment ON Payment FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Payment */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Payment  REF_EXPENSE_PAYMENT on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000339a7", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="REF_EXPENSE_PAYMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="PaymentId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_EXPENSE_PAYMENT
      WHERE
        /*  %JoinFKPK(REF_EXPENSE_PAYMENT,deleted," = "," AND") */
        REF_EXPENSE_PAYMENT.PaymentId = deleted.PaymentId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Payment because REF_EXPENSE_PAYMENT exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Campaign  Payment on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="CampId" */
    IF EXISTS (SELECT * FROM deleted,Campaign
      WHERE
        /* %JoinFKPK(deleted,Campaign," = "," AND") */
        deleted.CampId = Campaign.CampId AND
        NOT EXISTS (
          SELECT * FROM Payment
          WHERE
            /* %JoinFKPK(Payment,Campaign," = "," AND") */
            Payment.CampId = Campaign.CampId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Payment because Campaign exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Fund  Payment on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="FundId" */
    IF EXISTS (SELECT * FROM deleted,Fund
      WHERE
        /* %JoinFKPK(deleted,Fund," = "," AND") */
        deleted.FundId = Fund.FundId AND
        NOT EXISTS (
          SELECT * FROM Payment
          WHERE
            /* %JoinFKPK(Payment,Fund," = "," AND") */
            Payment.FundId = Fund.FundId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Payment because Fund exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Payment ON Payment FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Payment */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insPaymentId integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Payment  REF_EXPENSE_PAYMENT on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0003dbd0", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="REF_EXPENSE_PAYMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="PaymentId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(PaymentId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_EXPENSE_PAYMENT
      WHERE
        /*  %JoinFKPK(REF_EXPENSE_PAYMENT,deleted," = "," AND") */
        REF_EXPENSE_PAYMENT.PaymentId = deleted.PaymentId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Payment because REF_EXPENSE_PAYMENT exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Campaign  Payment on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_28", FK_COLUMNS="CampId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CampId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Campaign
        WHERE
          /* %JoinFKPK(inserted,Campaign) */
          inserted.CampId = Campaign.CampId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.CampId IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Payment because Campaign does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Fund  Payment on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="Payment"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_32", FK_COLUMNS="FundId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(FundId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Fund
        WHERE
          /* %JoinFKPK(inserted,Fund) */
          inserted.FundId = Fund.FundId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.FundId IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Payment because Fund does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_PaymentMethod ON PaymentMethod FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on PaymentMethod */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* PaymentMethod  REF_FUND_CAMP_DONOR on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000108d6", PARENT_OWNER="", PARENT_TABLE="PaymentMethod"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="PayMethodId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_FUND_CAMP_DONOR
      WHERE
        /*  %JoinFKPK(REF_FUND_CAMP_DONOR,deleted," = "," AND") */
        REF_FUND_CAMP_DONOR.PayMethodId = deleted.PayMethodId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete PaymentMethod because REF_FUND_CAMP_DONOR exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_PaymentMethod ON PaymentMethod FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on PaymentMethod */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insPayMethodId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* PaymentMethod  REF_FUND_CAMP_DONOR on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00012c83", PARENT_OWNER="", PARENT_TABLE="PaymentMethod"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="PayMethodId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(PayMethodId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_FUND_CAMP_DONOR
      WHERE
        /*  %JoinFKPK(REF_FUND_CAMP_DONOR,deleted," = "," AND") */
        REF_FUND_CAMP_DONOR.PayMethodId = deleted.PayMethodId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update PaymentMethod because REF_FUND_CAMP_DONOR exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_REF_CAMP_BLOG ON REF_CAMP_BLOG FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on REF_CAMP_BLOG */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Campaign  REF_CAMP_BLOG on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00024b5b", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="REF_CAMP_BLOG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="CampId" */
    IF EXISTS (SELECT * FROM deleted,Campaign
      WHERE
        /* %JoinFKPK(deleted,Campaign," = "," AND") */
        deleted.CampId = Campaign.CampId AND
        NOT EXISTS (
          SELECT * FROM REF_CAMP_BLOG
          WHERE
            /* %JoinFKPK(REF_CAMP_BLOG,Campaign," = "," AND") */
            REF_CAMP_BLOG.CampId = Campaign.CampId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_CAMP_BLOG because Campaign exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Blog  REF_CAMP_BLOG on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Blog"
    CHILD_OWNER="", CHILD_TABLE="REF_CAMP_BLOG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="BlogId" */
    IF EXISTS (SELECT * FROM deleted,Blog
      WHERE
        /* %JoinFKPK(deleted,Blog," = "," AND") */
        deleted.BlogId = Blog.BlogId AND
        NOT EXISTS (
          SELECT * FROM REF_CAMP_BLOG
          WHERE
            /* %JoinFKPK(REF_CAMP_BLOG,Blog," = "," AND") */
            REF_CAMP_BLOG.BlogId = Blog.BlogId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_CAMP_BLOG because Blog exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_REF_CAMP_BLOG ON REF_CAMP_BLOG FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on REF_CAMP_BLOG */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insCampId int, 
           @insBlogId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Campaign  REF_CAMP_BLOG on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000277e7", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="REF_CAMP_BLOG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_25", FK_COLUMNS="CampId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CampId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Campaign
        WHERE
          /* %JoinFKPK(inserted,Campaign) */
          inserted.CampId = Campaign.CampId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_CAMP_BLOG because Campaign does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Blog  REF_CAMP_BLOG on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Blog"
    CHILD_OWNER="", CHILD_TABLE="REF_CAMP_BLOG"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="BlogId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(BlogId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Blog
        WHERE
          /* %JoinFKPK(inserted,Blog) */
          inserted.BlogId = Blog.BlogId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_CAMP_BLOG because Blog does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_REF_DONOR_FUND ON REF_DONOR_FUND FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on REF_DONOR_FUND */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Donor  REF_DONOR_FUND on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00024d33", PARENT_OWNER="", PARENT_TABLE="Donor"
    CHILD_OWNER="", CHILD_TABLE="REF_DONOR_FUND"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="DonorId" */
    IF EXISTS (SELECT * FROM deleted,Donor
      WHERE
        /* %JoinFKPK(deleted,Donor," = "," AND") */
        deleted.DonorId = Donor.DonorId AND
        NOT EXISTS (
          SELECT * FROM REF_DONOR_FUND
          WHERE
            /* %JoinFKPK(REF_DONOR_FUND,Donor," = "," AND") */
            REF_DONOR_FUND.DonorId = Donor.DonorId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_DONOR_FUND because Donor exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Fund  REF_DONOR_FUND on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="REF_DONOR_FUND"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="FundId" */
    IF EXISTS (SELECT * FROM deleted,Fund
      WHERE
        /* %JoinFKPK(deleted,Fund," = "," AND") */
        deleted.FundId = Fund.FundId AND
        NOT EXISTS (
          SELECT * FROM REF_DONOR_FUND
          WHERE
            /* %JoinFKPK(REF_DONOR_FUND,Fund," = "," AND") */
            REF_DONOR_FUND.FundId = Fund.FundId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_DONOR_FUND because Fund exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_REF_DONOR_FUND ON REF_DONOR_FUND FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on REF_DONOR_FUND */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insDonorId int, 
           @insFundId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Donor  REF_DONOR_FUND on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000293b1", PARENT_OWNER="", PARENT_TABLE="Donor"
    CHILD_OWNER="", CHILD_TABLE="REF_DONOR_FUND"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_33", FK_COLUMNS="DonorId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DonorId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Donor
        WHERE
          /* %JoinFKPK(inserted,Donor) */
          inserted.DonorId = Donor.DonorId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_DONOR_FUND because Donor does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Fund  REF_DONOR_FUND on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="REF_DONOR_FUND"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_35", FK_COLUMNS="FundId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(FundId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Fund
        WHERE
          /* %JoinFKPK(inserted,Fund) */
          inserted.FundId = Fund.FundId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_DONOR_FUND because Fund does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_REF_EMP_GROUP ON REF_EMP_GROUP FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on REF_EMP_GROUP */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Employee  REF_EMP_GROUP on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00025db3", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="REF_EMP_GROUP"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="EmpId" */
    IF EXISTS (SELECT * FROM deleted,Employee
      WHERE
        /* %JoinFKPK(deleted,Employee," = "," AND") */
        deleted.EmpId = Employee.EmpId AND
        NOT EXISTS (
          SELECT * FROM REF_EMP_GROUP
          WHERE
            /* %JoinFKPK(REF_EMP_GROUP,Employee," = "," AND") */
            REF_EMP_GROUP.EmpId = Employee.EmpId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_EMP_GROUP because Employee exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Groups  REF_EMP_GROUP on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="REF_EMP_GROUP"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="GroupId" */
    IF EXISTS (SELECT * FROM deleted,Groups
      WHERE
        /* %JoinFKPK(deleted,Groups," = "," AND") */
        deleted.GroupId = Groups.GroupId AND
        NOT EXISTS (
          SELECT * FROM REF_EMP_GROUP
          WHERE
            /* %JoinFKPK(REF_EMP_GROUP,Groups," = "," AND") */
            REF_EMP_GROUP.GroupId = Groups.GroupId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_EMP_GROUP because Groups exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_REF_EMP_GROUP ON REF_EMP_GROUP FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on REF_EMP_GROUP */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insEmpId int, 
           @insGroupId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Employee  REF_EMP_GROUP on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002880d", PARENT_OWNER="", PARENT_TABLE="Employee"
    CHILD_OWNER="", CHILD_TABLE="REF_EMP_GROUP"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="EmpId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(EmpId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Employee
        WHERE
          /* %JoinFKPK(inserted,Employee) */
          inserted.EmpId = Employee.EmpId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_EMP_GROUP because Employee does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Groups  REF_EMP_GROUP on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="REF_EMP_GROUP"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="GroupId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(GroupId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Groups
        WHERE
          /* %JoinFKPK(inserted,Groups) */
          inserted.GroupId = Groups.GroupId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_EMP_GROUP because Groups does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_REF_EXPENSE_PAYMENT ON REF_EXPENSE_PAYMENT FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on REF_EXPENSE_PAYMENT */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Expense  REF_EXPENSE_PAYMENT on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00027ec1", PARENT_OWNER="", PARENT_TABLE="Expense"
    CHILD_OWNER="", CHILD_TABLE="REF_EXPENSE_PAYMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="ExpenseId" */
    IF EXISTS (SELECT * FROM deleted,Expense
      WHERE
        /* %JoinFKPK(deleted,Expense," = "," AND") */
        deleted.ExpenseId = Expense.ExpenseId AND
        NOT EXISTS (
          SELECT * FROM REF_EXPENSE_PAYMENT
          WHERE
            /* %JoinFKPK(REF_EXPENSE_PAYMENT,Expense," = "," AND") */
            REF_EXPENSE_PAYMENT.ExpenseId = Expense.ExpenseId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_EXPENSE_PAYMENT because Expense exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Payment  REF_EXPENSE_PAYMENT on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="REF_EXPENSE_PAYMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="PaymentId" */
    IF EXISTS (SELECT * FROM deleted,Payment
      WHERE
        /* %JoinFKPK(deleted,Payment," = "," AND") */
        deleted.PaymentId = Payment.PaymentId AND
        NOT EXISTS (
          SELECT * FROM REF_EXPENSE_PAYMENT
          WHERE
            /* %JoinFKPK(REF_EXPENSE_PAYMENT,Payment," = "," AND") */
            REF_EXPENSE_PAYMENT.PaymentId = Payment.PaymentId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_EXPENSE_PAYMENT because Payment exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_REF_EXPENSE_PAYMENT ON REF_EXPENSE_PAYMENT FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on REF_EXPENSE_PAYMENT */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insExpenseId int, 
           @insPaymentId integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Expense  REF_EXPENSE_PAYMENT on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002ac17", PARENT_OWNER="", PARENT_TABLE="Expense"
    CHILD_OWNER="", CHILD_TABLE="REF_EXPENSE_PAYMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_29", FK_COLUMNS="ExpenseId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ExpenseId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Expense
        WHERE
          /* %JoinFKPK(inserted,Expense) */
          inserted.ExpenseId = Expense.ExpenseId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_EXPENSE_PAYMENT because Expense does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Payment  REF_EXPENSE_PAYMENT on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Payment"
    CHILD_OWNER="", CHILD_TABLE="REF_EXPENSE_PAYMENT"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_31", FK_COLUMNS="PaymentId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PaymentId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Payment
        WHERE
          /* %JoinFKPK(inserted,Payment) */
          inserted.PaymentId = Payment.PaymentId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_EXPENSE_PAYMENT because Payment does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_REF_FUND_CAMP_DONOR ON REF_FUND_CAMP_DONOR FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on REF_FUND_CAMP_DONOR */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Fund  REF_FUND_CAMP_DONOR on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0004f2c4", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="FundId" */
    IF EXISTS (SELECT * FROM deleted,Fund
      WHERE
        /* %JoinFKPK(deleted,Fund," = "," AND") */
        deleted.FundId = Fund.FundId AND
        NOT EXISTS (
          SELECT * FROM REF_FUND_CAMP_DONOR
          WHERE
            /* %JoinFKPK(REF_FUND_CAMP_DONOR,Fund," = "," AND") */
            REF_FUND_CAMP_DONOR.FundId = Fund.FundId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_FUND_CAMP_DONOR because Fund exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Campaign  REF_FUND_CAMP_DONOR on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_38", FK_COLUMNS="CampId" */
    IF EXISTS (SELECT * FROM deleted,Campaign
      WHERE
        /* %JoinFKPK(deleted,Campaign," = "," AND") */
        deleted.CampId = Campaign.CampId AND
        NOT EXISTS (
          SELECT * FROM REF_FUND_CAMP_DONOR
          WHERE
            /* %JoinFKPK(REF_FUND_CAMP_DONOR,Campaign," = "," AND") */
            REF_FUND_CAMP_DONOR.CampId = Campaign.CampId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_FUND_CAMP_DONOR because Campaign exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Donor  REF_FUND_CAMP_DONOR on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Donor"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="DonorId" */
    IF EXISTS (SELECT * FROM deleted,Donor
      WHERE
        /* %JoinFKPK(deleted,Donor," = "," AND") */
        deleted.DonorId = Donor.DonorId AND
        NOT EXISTS (
          SELECT * FROM REF_FUND_CAMP_DONOR
          WHERE
            /* %JoinFKPK(REF_FUND_CAMP_DONOR,Donor," = "," AND") */
            REF_FUND_CAMP_DONOR.DonorId = Donor.DonorId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_FUND_CAMP_DONOR because Donor exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* PaymentMethod  REF_FUND_CAMP_DONOR on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="PaymentMethod"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="PayMethodId" */
    IF EXISTS (SELECT * FROM deleted,PaymentMethod
      WHERE
        /* %JoinFKPK(deleted,PaymentMethod," = "," AND") */
        deleted.PayMethodId = PaymentMethod.PayMethodId AND
        NOT EXISTS (
          SELECT * FROM REF_FUND_CAMP_DONOR
          WHERE
            /* %JoinFKPK(REF_FUND_CAMP_DONOR,PaymentMethod," = "," AND") */
            REF_FUND_CAMP_DONOR.PayMethodId = PaymentMethod.PayMethodId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_FUND_CAMP_DONOR because PaymentMethod exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_REF_FUND_CAMP_DONOR ON REF_FUND_CAMP_DONOR FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on REF_FUND_CAMP_DONOR */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insFundId int, 
           @insCampId int, 
           @insDonorId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Fund  REF_FUND_CAMP_DONOR on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00055934", PARENT_OWNER="", PARENT_TABLE="Fund"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_36", FK_COLUMNS="FundId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(FundId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Fund
        WHERE
          /* %JoinFKPK(inserted,Fund) */
          inserted.FundId = Fund.FundId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_FUND_CAMP_DONOR because Fund does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Campaign  REF_FUND_CAMP_DONOR on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Campaign"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_38", FK_COLUMNS="CampId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(CampId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Campaign
        WHERE
          /* %JoinFKPK(inserted,Campaign) */
          inserted.CampId = Campaign.CampId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_FUND_CAMP_DONOR because Campaign does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Donor  REF_FUND_CAMP_DONOR on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Donor"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_39", FK_COLUMNS="DonorId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(DonorId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Donor
        WHERE
          /* %JoinFKPK(inserted,Donor) */
          inserted.DonorId = Donor.DonorId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_FUND_CAMP_DONOR because Donor does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* PaymentMethod  REF_FUND_CAMP_DONOR on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="PaymentMethod"
    CHILD_OWNER="", CHILD_TABLE="REF_FUND_CAMP_DONOR"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_40", FK_COLUMNS="PayMethodId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PayMethodId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,PaymentMethod
        WHERE
          /* %JoinFKPK(inserted,PaymentMethod) */
          inserted.PayMethodId = PaymentMethod.PayMethodId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.PayMethodId IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_FUND_CAMP_DONOR because PaymentMethod does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_REF_GROUPS_ROLE ON REF_GROUPS_ROLE FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on REF_GROUPS_ROLE */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Groups  REF_GROUPS_ROLE on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00024c80", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="REF_GROUPS_ROLE"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="GroupId" */
    IF EXISTS (SELECT * FROM deleted,Groups
      WHERE
        /* %JoinFKPK(deleted,Groups," = "," AND") */
        deleted.GroupId = Groups.GroupId AND
        NOT EXISTS (
          SELECT * FROM REF_GROUPS_ROLE
          WHERE
            /* %JoinFKPK(REF_GROUPS_ROLE,Groups," = "," AND") */
            REF_GROUPS_ROLE.GroupId = Groups.GroupId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_GROUPS_ROLE because Groups exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Role  REF_GROUPS_ROLE on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Role"
    CHILD_OWNER="", CHILD_TABLE="REF_GROUPS_ROLE"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="RoleId" */
    IF EXISTS (SELECT * FROM deleted,Role
      WHERE
        /* %JoinFKPK(deleted,Role," = "," AND") */
        deleted.RoleId = Role.RoleId AND
        NOT EXISTS (
          SELECT * FROM REF_GROUPS_ROLE
          WHERE
            /* %JoinFKPK(REF_GROUPS_ROLE,Role," = "," AND") */
            REF_GROUPS_ROLE.RoleId = Role.RoleId
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last REF_GROUPS_ROLE because Role exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_REF_GROUPS_ROLE ON REF_GROUPS_ROLE FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on REF_GROUPS_ROLE */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insGroupId int, 
           @insRoleId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Groups  REF_GROUPS_ROLE on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00028f25", PARENT_OWNER="", PARENT_TABLE="Groups"
    CHILD_OWNER="", CHILD_TABLE="REF_GROUPS_ROLE"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="GroupId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(GroupId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Groups
        WHERE
          /* %JoinFKPK(inserted,Groups) */
          inserted.GroupId = Groups.GroupId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_GROUPS_ROLE because Groups does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Role  REF_GROUPS_ROLE on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Role"
    CHILD_OWNER="", CHILD_TABLE="REF_GROUPS_ROLE"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="RoleId" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(RoleId)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Role
        WHERE
          /* %JoinFKPK(inserted,Role) */
          inserted.RoleId = Role.RoleId
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update REF_GROUPS_ROLE because Role does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Role ON Role FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Role */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Role  REF_GROUPS_ROLE on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000fa61", PARENT_OWNER="", PARENT_TABLE="Role"
    CHILD_OWNER="", CHILD_TABLE="REF_GROUPS_ROLE"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="RoleId" */
    IF EXISTS (
      SELECT * FROM deleted,REF_GROUPS_ROLE
      WHERE
        /*  %JoinFKPK(REF_GROUPS_ROLE,deleted," = "," AND") */
        REF_GROUPS_ROLE.RoleId = deleted.RoleId
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Role because REF_GROUPS_ROLE exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Role ON Role FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Role */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insRoleId int,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Role  REF_GROUPS_ROLE on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000116cd", PARENT_OWNER="", PARENT_TABLE="Role"
    CHILD_OWNER="", CHILD_TABLE="REF_GROUPS_ROLE"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="RoleId" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(RoleId)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,REF_GROUPS_ROLE
      WHERE
        /*  %JoinFKPK(REF_GROUPS_ROLE,deleted," = "," AND") */
        REF_GROUPS_ROLE.RoleId = deleted.RoleId
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Role because REF_GROUPS_ROLE exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


