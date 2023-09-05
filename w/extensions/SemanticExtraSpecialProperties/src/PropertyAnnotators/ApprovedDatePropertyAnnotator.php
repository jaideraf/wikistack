<?php

namespace SESP\PropertyAnnotators;

use ApprovedRevs;
use MWTimestamp;
use SMW\DIProperty;
use SMW\SemanticData;
use SMWDataItem as DataItem;
use SMWDITime as DITime;
use SESP\PropertyAnnotator;
use SESP\AppFactory;

/**
 * @private
 * @ingroup SESP
 *
 * @license GNU GPL v2+
 */
class ApprovedDatePropertyAnnotator implements PropertyAnnotator {

	/**
	 * Predefined property ID
	 */
	const PROP_ID = '___APPROVEDDATE';

	/**
	 * @var AppFactory
	 */
	private $appFactory;

	/**
	 * @var Integer|null
	 */
	private $approvedDate;

	/**
	 * @param AppFactory $appFactory
	 */
	public function __construct( AppFactory $appFactory ) {
		$this->appFactory = $appFactory;
	}

	/**
	 * @since 2.0
	 *
	 * @param Integer $approvedDate
	 */
	public function setApprovedDate( $approvedDate ) {
		$this->approvedDate = $approvedDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public function isAnnotatorFor( DIProperty $property ) {
		return $property->getKey() === self::PROP_ID;
	}

	/**
	 * {@inheritDoc}
	 */
	public function addAnnotation( DIProperty $property, SemanticData $semanticData ) {
		if ( $this->approvedDate === null && class_exists( 'ApprovedRevs' ) ) {
			// ApprovedRevs does not provide a function to get the approval date,
			// so fetch it here from the ApprovedRevs table
			$pageID = $semanticData->getSubject()->getTitle()->getArticleID();
			$dbr = wfGetDB( DB_REPLICA );
			$approval_date = $dbr->selectField( 'approved_revs', 'approval_date', [ 'page_id' => $pageID ] );
			
			if ( $approval_date ) {
				$this->approvedDate = new MWTimestamp( wfTimestamp( TS_MW, $approval_date ) );
			}
		}

		$dataItem = $this->getDataItem();
		if ( $dataItem ) {
			$semanticData->addPropertyObjectValue( $property, $dataItem );
		} else {
			$semanticData->removeProperty( $property );
		}
	}

	private function getDataItem() {
		if ( $this->approvedDate ) {
			$date = $this->approvedDate;
			return new DITime(
				DITime::CM_GREGORIAN,
				$date->format( 'Y' ),
				$date->format( 'm' ),
				$date->format( 'd' ),
				$date->format( 'H' ),
				$date->format( 'i' )
			);
		}
	}

}
