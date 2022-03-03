
import 'dart:typed_data';

class Note {

  int _id ;
  String _title=" ";
  String _description=" ";
  String _date=" ";
  int _priority;
  String _ghcardpicture=" ";
  String _nhispicture=" ";
  String _snnitpicture=" ";
  String _licencepicture=" ";
  String _voteridpicture=" ";
  String _passportpicture;
  String _ghcardsurname=" ";
  String _ghcardfirstname=" ";
  String _ghcardpreviousname=" ";
  String _ghcardnationality=" ";
  String _ghcardsex=" ";
  String _ghcarddateofbirth=" ";
  String _ghcardplaceofissuance=" ";
  String _ghcardid=" ";
  String _ghcardheight=" ";
  String _ghcarddateofissuance=" ";
  String _ghcarddateofexpiry=" ";
  String _ghcarddocumentnumber=" ";
  
  String _passportid=" ";

  String _nhisname=" ";
  String _nhissex=" ";
  String _nhisdateofbirth=" ";
  String _nhisid=" ";
  String _nhisdateofissuance=" ";
  String _nhisdateofexpiry=" ";

  String _licencename=" ";
  String _licencenationalid=" ";
  String _licenceprocessingcenter=" ";
  String _licencenationality=" ";
  String _licenceclass=" ";
  String _licencedateofbirth=" ";
  String _dateoffirstlicence=" ";
  String _licencepin=" ";
  String _licencedateofissue=" ";
  String _licencedateofexpiry=" ";
  String _licencecertificatedate=" ";
  String _certificateofcompetence=" ";

  String _snnitname=" ";
  String _snnitgender=" ";
  String _snnitdateofbirth=" ";
  String _snnitid=" ";

  String _voteridsurname=" ";
  String _voteridothername=" ";
  String _voteridsex=" ";
  String _voteriddateofbirth=" ";
  String _voteridpollingstationcode=" ";
  String _voteriddateofregistration=" ";
  String _voteridnumber=" ";
  
  String _dob=" ";

 

  Note(this._title,this._dob,this._date,
      this._priority, [this._ghcardsurname,

        this._ghcardfirstname,
        this._ghcardpreviousname,
        this._ghcardnationality,
        this._ghcardsex,
        this._ghcarddateofbirth,
        this._ghcardplaceofissuance,
        this._ghcardid,
        this._ghcardheight,
        this._ghcarddateofissuance,
        this._ghcarddateofexpiry,
        this._ghcarddocumentnumber,

        this._passportid,

        this._nhisname,
        this._nhissex,
        this._nhisdateofbirth,
        this._nhisid,
        this._nhisdateofissuance,
        this._nhisdateofexpiry,

        this._licencename,
        this._licencenationalid,
        this._licenceprocessingcenter,
        this._licencenationality,
        this._licenceclass,
        this._licencedateofbirth,
        this._dateoffirstlicence,
        this._licencepin,
        this._licencedateofissue,
        this._licencedateofexpiry,
        this._licencecertificatedate,
        this._certificateofcompetence,

        this._snnitname,
        this._snnitgender,
        this._snnitdateofbirth,
        this._snnitid,

        this._voteridsurname,
        this._voteridothername,
        this._voteridsex,
        this._voteriddateofbirth,
        this._voteridpollingstationcode,
        this._voteriddateofregistration,
        this._voteridnumber,

        this._ghcardpicture,
        this._licencepicture,
        this._nhispicture,
        this._snnitpicture,
        this._voteridpicture,

        this._description]);

  Note.withId(this._id, this._dob,this._title, this._date,

     this._priority, [this._ghcardsurname,

        
        this._ghcardfirstname,
        this._ghcardpreviousname,
        this._ghcardnationality,
        this._ghcardsex,
        this._ghcarddateofbirth,
        this._ghcardplaceofissuance,
        this._ghcardid,
        this._ghcardheight,
        this._ghcarddateofissuance,
        this._ghcarddateofexpiry,
        this._ghcarddocumentnumber,


        this._nhisname,
        this._nhissex,
        this._nhisdateofbirth,
        this._nhisid,
        this._nhisdateofissuance,
        this._nhisdateofexpiry,

        this._licencename,
        this._licencenationalid,
        this._licenceprocessingcenter,
        this._licencenationality,
        this._licenceclass,
        this._licencedateofbirth, this._dateoffirstlicence,
        this._licencepin,
        this._licencedateofissue,
        this._licencedateofexpiry,
        this._licencecertificatedate,
        this._certificateofcompetence,

        this._snnitname,
        this._snnitgender,
        this._snnitdateofbirth,
        this._snnitid,

        this._voteridsurname,
        this._voteridothername,
        this._voteridsex,
        this._voteriddateofbirth,
        this._voteridpollingstationcode,
        this._voteriddateofregistration,
        this._voteridnumber,
        this._ghcardpicture,
        this._licencepicture,
        this._nhispicture,
        this._snnitpicture,
        this._voteridpicture,
        this._description]);
  int get id => _id;



  String get title => _title;

  String get description => _description;

  int get priority => _priority;

  String get date => _date;
  String get dob => _dob;

  String get ghcardsurname => _ghcardsurname;
  String get ghcardfirstname => _ghcardfirstname;
  String get ghcardpreviousname => _ghcardpreviousname;
  String get ghcardnationality => _ghcardnationality;
  String get ghcardsex => _ghcardsex;
  String get ghcarddateofbirth => _ghcarddateofbirth;
  String get ghcardplaceofissuance => _ghcardplaceofissuance;
  String get ghcardid => _ghcardid;
  String get ghcardheight => _ghcardheight;
  String get ghcarddateofissuance => _ghcarddateofissuance;
  String get ghcarddateofexpiry => _ghcarddateofexpiry;
  String get ghcarddocumentnumber => _ghcarddocumentnumber;

  

  String get nhisname => _nhisname;
  String get nhissex => _nhissex;
  String get nhisdateofbirth => _nhisdateofbirth;
  String get nhisid => _nhisid;
  String get nhisdateofissuance => _nhisdateofissuance;
  String get nhisdateofexpiry => _nhisdateofexpiry;

  String get licencename => _licencename;
  String get licencenationalid => _licencenationalid;
  String get licenceprocessingcenter => _licenceprocessingcenter;
  String get licencenationality => _licencenationality;
  String get licenceclass => _licenceclass;
  String get licencedateofbirth => _licencedateofbirth;
  String get dateoffirstlicence => _dateoffirstlicence;
  String get licencepin => _licencepin;
  String get licencedateofissue => _licencedateofissue;
  String get licencedateofexpiry => _licencedateofexpiry;
  String get licencecertificatedate => _licencecertificatedate;
  String get certificateofcompetence => _certificateofcompetence;

  String get snnitname => _snnitname;
  String get snnitgender => _snnitgender;
  String get snnitdateofbirth => _snnitdateofbirth;
  String get snnitid => _snnitid;

  String get voteridsurname => _voteridsurname;
  String get voteridothername => _voteridothername;
  String get voteridsex => _voteridsex;
  String get voteriddateofbirth => _voteriddateofbirth;
  String get voteridpollingstationcode => _voteridpollingstationcode;
  String get voteriddateofregistration => _voteriddateofregistration;
  String get voteridnumber => _voteridnumber;

  String get ghcardpicture => _ghcardpicture;
  String get nhispicture => _nhispicture;
  String get snnitpicture => _snnitpicture;
  String get licencepicture => _licencepicture;
  String get voteridpicture => _voteridpicture;


  

    set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }
  set id(int newid) {
    if (newid!= 7) {
      this._id = newid;
    }
  }
  

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set ghcardid(String newGhcardid) {
    if (newGhcardid.length <= 255) {
      this._ghcardid =newGhcardid;
    }
  }
  

  
  set ghcardsex(String newGhcardsex) {
    if (newGhcardsex.length <= 255) {
      this._ghcardsex =newGhcardsex;
    }
  }
  set ghcardheight(String newGhcardheight) {
    if (newGhcardheight.length <= 255) {
      this._ghcardheight =newGhcardheight;
    }
  }
  set ghcardpreviousname(String newGhcardpreviousname) {
    if (newGhcardpreviousname.length <= 255) {
      this._ghcardpreviousname =newGhcardpreviousname;
    }
  }
  set ghcardfirstname(String newGhcardfirstname) {
    if (newGhcardfirstname.length <= 255) {
      this._ghcardfirstname =newGhcardfirstname;
    }
  }
  set ghcardsurname(String newGhcardsurname) {
    if (newGhcardsurname.length <= 255) {
      this._ghcardsurname =newGhcardsurname;
    }
  }
  set ghcarddateofbirth(String newGhcarddateofbirth) {
    if (newGhcarddateofbirth.length <= 255) {
      this._ghcarddateofbirth =newGhcarddateofbirth;
    }
  }
  set ghcarddateofissuance(String newGhcarddateofissuance) {
    if (newGhcarddateofissuance.length <= 255) {
      this._ghcarddateofissuance =newGhcarddateofissuance;
    }
  }
  set ghcardplaceofissuance(String newGhcardplaceofissuance) {
    if (newGhcardplaceofissuance.length <= 255) {
      this._ghcardplaceofissuance =newGhcardplaceofissuance;
    }
  }
  set ghcarddateofexpiry(String newGhcarddateofexpiry) {
    if (newGhcarddateofexpiry.length <= 255) {
      this._ghcarddateofexpiry =newGhcarddateofexpiry;
    }
  }
  set ghcarddocumentnumber(String newGhcarddocumentnumber) {
    if (newGhcarddocumentnumber.length <= 255) {
      this._ghcarddocumentnumber =newGhcarddocumentnumber;
    }
  }
  set ghcardnationality(String newGhcardnationality) {
    if (newGhcardnationality.length <= 255) {
      this._ghcardnationality =newGhcardnationality;
    }
  }
  set nhisid(String newnhisid) {
    if (newnhisid.length <= 255) {
      this._nhisid =newnhisid;
    }
  }
  set nhissex(String newnhissex) {
    if (newnhissex.length <= 255) {
      this._nhissex =newnhissex;
    }
  }
  set nhisname(String newnhisname) {
    if (newnhisname.length <= 255) {
      this._nhisname =newnhisname;
    }
  }
  set nhisdateofbirth(String newnhisdateofbirth) {
    if (newnhisdateofbirth.length <= 255) {
      this._nhisdateofbirth =newnhisdateofbirth;
    }
  }
  set nhisdateofissuance(String newnhisdateofissuance) {
    if (newnhisdateofissuance.length <= 255) {
      this._nhisdateofissuance =newnhisdateofissuance;
    }
  }
  set nhisdateofexpiry(String newnhisdateofexpiry) {
    if (newnhisdateofexpiry.length <= 255) {
      this._nhisdateofexpiry =newnhisdateofexpiry;
    }
  }
  set snnitid(String newsnnitid) {
    if (newsnnitid.length <= 255) {
      this._snnitid =newsnnitid;
    }
  }
  set snnitgender(String newsnnitgender) {
    if (newsnnitgender.length <= 255) {
      this._snnitgender =newsnnitgender;
    }
  }
  set snnitname(String newsnnitname) {
    if (newsnnitname.length <= 255) {
      this._snnitname =newsnnitname;
    }
  }
  set snnitdateofbirth(String newsnnitdateofbirth) {
    if (newsnnitdateofbirth.length <= 255) {
      this._snnitdateofbirth =newsnnitdateofbirth;
    }
  }
  set voteridnumber(String newvoteridnumber) {
    if (newvoteridnumber.length <= 255) {
      this._voteridnumber =newvoteridnumber;
    }
  }
  set voteridsex(String newvoteridsex) {
    if (newvoteridsex.length <= 255) {
      this._voteridsex =newvoteridsex;
    }
  }
  set voteridothername(String newvoteridothername) {
    if (newvoteridothername.length <= 255) {
      this._voteridothername =newvoteridothername;
    }
  }
  set voteridsurname(String newvoteridsurname) {
    if (newvoteridsurname.length <= 255) {
      this._voteridsurname =newvoteridsurname;
    }
  }
  set voteriddateofbirth(String newvoteriddateofbirth) {
    if (newvoteriddateofbirth.length <= 255) {
      this._voteriddateofbirth =newvoteriddateofbirth;
    }
  }
  set voteriddateofregistration(String newvoteriddateofregistration) {
    if (newvoteriddateofregistration.length <= 255) {
      this._voteriddateofregistration =newvoteriddateofregistration;
    }
  }
  set voteridpollingstationcode(String newvoteridpollingstationcode) {
    if (newvoteridpollingstationcode.length <= 255) {
      this._voteridpollingstationcode =newvoteridpollingstationcode;
    }
  }
  set licencepin(String newlicencepin) {
    if (newlicencepin.length <= 255) {
      this._licencepin =newlicencepin;
    }
  }
  set licenceclass(String newlicenceclass) {
    if (newlicenceclass.length <= 255) {
      this._licenceclass =newlicenceclass;
    }
  }
  set licencecertificatedate(String newlicencecertificatedate) {
    if (newlicencecertificatedate.length <= 255) {
      this._licencecertificatedate =newlicencecertificatedate;
    }
  }
  set certificateofcompetence(String newcertificateofcompetence) {
    if (newcertificateofcompetence.length <= 255) {
      this._certificateofcompetence =newcertificateofcompetence;
    }
  }
  set licenceprocessingcenter(String newlicenceprocessingcenter) {
    if (newlicenceprocessingcenter.length <= 255) {
      this._licenceprocessingcenter =newlicenceprocessingcenter;
    }
  }
  set licencename(String newlicencename) {
    if (newlicencename.length <= 255) {
      this._licencename =newlicencename;
    }
  }
  set licencedateofbirth(String newlicencedateofbirth) {
    if (newlicencedateofbirth.length <= 255) {
      this._licencedateofbirth =newlicencedateofbirth;
    }
  }
  set licencedateofissue(String newlicencedateofissue) {
    if (newlicencedateofissue.length <= 255) {
      this._licencedateofissue =newlicencedateofissue;
    }
  }
  set licencenationalid(String newlicencenationalid) {
    if (newlicencenationalid.length <= 255) {
      this._licencenationalid =newlicencenationalid;
    }
  }
  set dateoffirstlicence(String newdateoffirstlicence) {
    if (newdateoffirstlicence.length <= 255) {
      this._dateoffirstlicence =newdateoffirstlicence;
    }
  }
  set licencedateofexpiry(String newlicencedateofexpiry) {
    if (newlicencedateofexpiry.length <= 255) {
      this._licencedateofexpiry =newlicencedateofexpiry;
    }
  }
  set licencenationality(String newlicencenationality) {
    if (newlicencenationality.length <= 255) {
      this._licencenationality =newlicencenationality;
    }
  }

  set ghcardpicture(String newghcardpicture) {
    if (newghcardpicture.length>=0) {
      this._ghcardpicture = newghcardpicture;
    }
  }
  set voteridpicture(String newvoteridpicture) {
    if (newvoteridpicture.length>=0) {
      this._voteridpicture = newvoteridpicture;
    }
  }
  set nhispicture(String newnhispicture) {
    if (newnhispicture.length>=0) {
      this._nhispicture = newnhispicture;
    }
  }
  set snnitpicture(String newsnnitpicture) {
    if (newsnnitpicture.length>=0) {
      this._snnitpicture = newsnnitpicture;
    }
  }
  set licencepicture(String newlicencepicture) {
    if (newlicencepicture.length>=0) {
      this._licencepicture = newlicencepicture;
    }
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    map['dob'] = _dob;


    map['ghcardsurname'] = _ghcardsurname;
    map['ghcardfirstname'] = _ghcardfirstname;
    map['ghcardpreviousname'] = _ghcardpreviousname;
    map['ghcardnationality'] = _ghcardnationality;
    map['ghcardsex'] = _ghcardsex;
    map['ghcarddateofbirth'] = _ghcarddateofbirth;
    map['ghcardplaceofissuance'] = _ghcardplaceofissuance;
    map['ghcardid'] = _ghcardid;
    map['ghcardheight'] = _ghcardheight;
    map['ghcarddateofissuance'] = _ghcarddateofissuance;
    map['ghcarddateofexpiry'] = _ghcarddateofexpiry;
    map['ghcarddocumentnumber'] = _ghcarddocumentnumber;

    map['nhisname'] = _nhisname;
    map['nhissex'] = _nhissex;
    map['nhisdateofbirth'] = _nhisdateofbirth;
    map['nhisid'] = _nhisid;
    map['nhisdateofissuance'] = _nhisdateofissuance;
    map['nhisdateofexpiry'] = _nhisdateofexpiry;

    map['licencename'] = _licencename;
    map['licencenationalid'] = _licencenationalid;
    map['licenceprocessingcenter'] = _licenceprocessingcenter;
    map['licencenationality'] = _licencenationality;
    map['licenceclass'] = _licenceclass;
    map['licencedateofbirth'] = _licencedateofbirth;
    map['dateoffirstlicence'] = _dateoffirstlicence;
    map['licencepin'] = _licencepin;
    map['licencedateofissue'] = _licencedateofissue;
    map['licencedateofexpiry'] = _licencedateofexpiry;
    map['licencecertificatedate'] = _licencecertificatedate;
    map['certificateofcompetence'] = _certificateofcompetence;

    map['snnitname'] = _snnitname;
    map['snnitgender'] = _snnitgender;
    map['snnitdateofbirth'] = _snnitdateofbirth;
    map['snnitid'] = _snnitid;

    map['voteridsurname'] = _voteridsurname;
    map['voteridothername'] = _voteridothername;
    map['voteridsex'] = _voteridsex;
    map['voteriddateofbirth'] = _voteriddateofbirth;
    map['voteridpollingstationcode'] = _voteridpollingstationcode;
    map['voteriddateofregistration'] = _voteriddateofregistration;
    map['voteridnumber'] = _voteridnumber;

    map['ghcardpicture'] = _ghcardpicture;
    map['voteridpicture'] = _voteridpicture;
    map['licencepicture'] = _licencepicture;
    map['nhispicture'] = _nhispicture;
    map['snnitpicture'] = _snnitpicture;


    return map;
  }

  // Extract a Note object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
    this._dob = map['dob'];


    this._ghcardsurname = map['ghcardsurname'];
    this._ghcardfirstname = map['ghcardfirstname'];
    this._ghcardpreviousname = map['ghcardpreviousname'];
    this._ghcardnationality = map['ghcardnationality'];
    this._ghcardsex = map['ghcardsex'];
    this._ghcarddateofbirth = map['ghcarddateofbirth'];
    this._ghcardplaceofissuance = map['ghcardplaceofissuance'];
    this._ghcardid = map['ghcardid'];
    this._ghcardheight = map['ghcardheight'];
    this._ghcarddateofissuance = map['ghcarddateofissuance'];
    this._ghcarddateofexpiry = map['ghcarddateofexpiry'];
    this._ghcarddocumentnumber = map['ghcarddocumentnumber'];

    this._nhisname = map['nhisname'];
    this._nhissex = map['nhissex'];
    this._nhisdateofbirth = map['nhisdateofbirth'];
    this._nhisid = map['nhisid'];
    this._nhisdateofissuance = map['nhisdateofissuance'];
    this._nhisdateofexpiry = map['nhisdateofexpiry'];

    this._licencename = map['licencename'];
    this._licencenationalid = map['licencenationalid'];
    this._licenceprocessingcenter = map['licenceprocessingcenter'];
    this._licencenationality = map['licencenationality'];
    this._licenceclass = map['licenceclass'];
    this._licencedateofbirth = map['licencedateofbirth'];
    this._dateoffirstlicence = map['dateoffirstlicence'];
    this._licencepin = map['licencepin'];
    this._licencedateofissue = map['licencedateofissue'];
    this._licencedateofexpiry = map['licencedateofexpiry'];
    this._licencecertificatedate = map['licencecertificatedate'];
    this._certificateofcompetence = map['certificateofcompetence'];

    this._snnitname = map['snnitname'];
    this._snnitgender = map['snnitgender'];
    this._snnitdateofbirth = map['snnitdateofbirth'];
    this._snnitid = map['snnitid'];

    this._voteridsurname = map['voteridsurname'];
    this._voteridothername = map['voteridothername'];
    this._voteridsex = map['voteridsex'];
    this._voteriddateofbirth = map['voteriddateofbirth'];
    this._voteridpollingstationcode = map['voteridpollingstationcode'];
    this._voteriddateofregistration = map['voteriddateofregistration'];
    this._voteridnumber = map['voteridnumber'];
    this._ghcardpicture = map['ghcardpicture'];
    this._nhispicture = map['nhispicture'];
    this._voteridpicture = map['voteridpicture'];
    this._snnitpicture = map['snnitpicture'];
    this._licencepicture = map['licencepicture'];
  }
}









