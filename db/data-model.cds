context dest_demofiori.db {

entity Sales {
  key ID       : Integer;
      region   : String(100);
      country  : String(100);
      org      : String(4);
      amount   : Integer;
      comments : String(100);
};

entity Widgets {
  key ID    : Integer;
      code  : String(10);
      stock : Integer;
};


}

@cds.persistence.exists
@cds.persistence.calcview
entity CV_SALES {
  key REGION  : String(100);
      AMOUNT  : Integer;
}

