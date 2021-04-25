package model;

public class Asiakas {
	int asiakas_id;
	String etunimi, sukunimi, sposti, puhelin;
	
	public Asiakas() {
		super();
	}

	public Asiakas(int asiakas_id, String etunimi, String sukunimi, String sposti, String puhelin) {
		super();
		this.asiakas_id = asiakas_id;
		this.etunimi = etunimi;
		this.sukunimi = sukunimi;
		this.sposti = sposti;
		this.puhelin = puhelin;
	}

	public int getAsiakas_id() {
		return asiakas_id;
	}

	public void setAsiakas_id(int asiakas_id) {
		this.asiakas_id = asiakas_id;
	}

	public String getEtunimi() {
		return etunimi;
	}

	public void setEtunimi(String etunimi) {
		this.etunimi = etunimi;
	}

	public String getSukunimi() {
		return sukunimi;
	}

	public void setSukunimi(String sukunimi) {
		this.sukunimi = sukunimi;
	}

	public String getSposti() {
		return sposti;
	}

	public void setSposti(String sposti) {
		this.sposti = sposti;
	}

	public String getPuhelin() {
		return puhelin;
	}

	public void setPuhelin(String puhelin) {
		this.puhelin = puhelin;
	}

	@Override
	public String toString() {
		return "Asiakas [asiakas_id=" + asiakas_id + ", etunimi=" + etunimi + ", sukunimi=" + sukunimi + ", sposti="
				+ sposti + ", puhelin=" + puhelin + "]";
	}
	

}
