package katri.avsc.egovframework.cmmn.util;

public class RequestURIModel {
	private String fullPath;
	private String firstPrefix;
	private String secondPrefix;
	private String action;

	/**
	 * @return the fullPath
	 */
	public String getFullPath() {
		return fullPath;
	}

	/**
	 * @param fullPath the fullPath to set
	 */
	public void setFullPath(String fullPath) {
		this.fullPath = fullPath;
	}

	/**
	 * @return the firstPrefix
	 */
	public String getFirstPrefix() {
		return firstPrefix;
	}

	/**
	 * @param firstPrefix the firstPrefix to set
	 */
	public void setFirstPrefix(String firstPrefix) {
		this.firstPrefix = firstPrefix;
	}

	/**
	 * @return the secondPrefix
	 */
	public String getSecondPrefix() {
		return secondPrefix;
	}

	/**
	 * @param secondPrefix the secondPrefix to set
	 */
	public void setSecondPrefix(String secondPrefix) {
		this.secondPrefix = secondPrefix;
	}

	/**
	 * @return the action
	 */
	public String getAction() {
		return action;
	}

	/**
	 * @param action the action to set
	 */
	public void setAction(String action) {
		this.action = action;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "RequestURIModel [action=" + action + ", firstPrefix="
				+ firstPrefix + ", fullPath=" + fullPath + ", secondPrefix="
				+ secondPrefix + "]";
	}
}
